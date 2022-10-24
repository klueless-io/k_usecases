# frozen_string_literal: true

module KUsecases
  class Usecase
    attr_reader :key
    attr_reader :title
    attr_reader :summary
    attr_reader :usage
    attr_reader :usage_description
    attr_reader :contents

    def initialize(key)
      @key = key
      @title = ''
      @summary = ''
      @usage = ''
      @usage_description = ''
      @contents = []
    end

    def self.parse(key, data)
      usecase = Usecase.new(key)

      usecase.build_title(data)
      usecase.build_attributes(data)

      # Loop through the it blocks
      data.examples.each do |it|
        usecase.add_content(it)
      end

      usecase
    end

    def to_h
      { 
        key: key,
        title: title,
        summary: summary,
        usage: usage,
        usage_description: usage_description,
        contents: contents.map { |content| content.to_h }
      }
    end

    def add_content(example)
      content = KUsecases::Content.parse(example)
      @contents << content unless content.nil?
    end

    def build_attributes(example_group)
      @summary = example_group.metadata[:summary] if example_group.metadata[:summary]

      @usage = example_group.metadata[:usage] if example_group.metadata[:usage]
      @usage_description = example_group.metadata[:usage_description] if example_group.metadata[:usage_description]
    end

    def build_title(example_group)
      return if title != ''

      if example_group.metadata[:title]
        @title = example_group.metadata[:title]
      else
        example_group.example_group.parent_groups.reverse.each do |group|
          @title = if @title.length.zero?
                            group.description
                          else
                            "#{@title} #{group.description}"
                          end
        end
      end
    end
  end
end
