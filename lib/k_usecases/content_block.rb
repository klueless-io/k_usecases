# frozen_string_literal: true

module KUsecases
  # Content block
  class ContentBlock
    attr_reader :label
    attr_reader :description

    def self.parse(example)
      return [] unless example.metadata[:content] && example.metadata[:content].is_a?(Array)

      blocks = example.metadata[:content].compact
      blocks = blocks.reject { |b| b[:label].nil? && b[:description].nil? }

      blocks.map do |b|
        ContentBlock.new(b[:label], b[:description]) 
      end
    end

    def initialize(label, description)
      @label = label || ''
      @description = description || ''
    end

    def to_h
      { 
        label: label,
        description: description
      }
    end
  end
end
