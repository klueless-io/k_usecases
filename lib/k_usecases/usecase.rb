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
      @content_hash = {}
    end

    def to_h
      { 
        key: key,
        title: title,
        usage: usage,
        outcomes: outcomes.map { |o| o.to_h },
        content_blocks: content_blocks
      }
    end

    # def printable
    #   @usage != ''
    # end

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

    def add_content(group)
      return if group.metadata[:content].nil? && !group.metadata[:content].is_a?(Array)

      group.metadata[:content].each do |content|
        key = "#{content[:label]}_#{content[:description]}"
        next if @content_hash.key?(key)

        @content_hash[key] = true
        content_blocks << KtgContent.new(content)
      end
    end

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
