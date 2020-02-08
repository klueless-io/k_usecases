# frozen_string_literal: true

module KUsecases
  # KTG Document
  class Usecase
    attr_reader :key
    attr_reader :title
    attr_reader :usage
    attr_reader :outcomes
    attr_reader :content_blocks

    def initialize(key)
      @key = key
      @title = ''
      @usage = ''
      @outcomes = []
      @content_blocks = []
    end

    def self.parse(key, data)
      usecase = Usecase.new(key)

      usecase.build_title(data)
      usecase.build_usage(data)
      usecase.build_content(data)

      # Loop through the it blocks
      data.examples.each do |it|
        usecase.add_outcome(it)
      end

      usecase
    end

    def to_h
      { 
        key: key,
        title: title,
        usage: usage,
        outcomes: outcomes.map { |outcome| outcome.to_h },
        content_blocks: content_blocks.map { |block| block.to_h }
      }
    end

    # def print
    #   puts description
    #   puts
    #   puts 'Usage:'
    #   puts "  #{usage}"
    #   puts
    #   puts 'Expected Outcomes:'
    #   outcomes.each(&:print)
    #   puts
    #   content_blocks.each(&:print)
    #   puts '-' * 120
    # end

    def add_outcome(example)
      outcome = KUsecases::Outcome.parse(example)
      @outcomes << outcome unless outcome.nil?
    end

    def build_content(example_group)
      @content_blocks = KUsecases::ContentBlock.parse(example_group)
    end

    def build_usage(example_group)
      @usage = example_group.metadata[:usage] if example_group.metadata[:usage]
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
