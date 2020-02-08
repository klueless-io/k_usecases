# frozen_string_literal: true

module KUsecases
  # Content block
  class ContentBlock
    attr_reader :title
    attr_reader :description
    attr_reader :type
    attr_reader :code_type

    def self.parse(example)
      return [] unless example.metadata[:content] && example.metadata[:content].is_a?(Array)

      blocks = example.metadata[:content].compact
      blocks = blocks.reject { |b| b[:title].nil? && b[:description].nil? }

      blocks.map do |b|
        ContentBlock.new(b[:title], b[:description], b[:type], b[:code_type]) 
      end
    end

    def initialize(title, description, type, code_type)
      @title = title || ''
      @description = description || ''
      @type = type || :text
      @code_type = code_type || ''
    end

    def to_h
      { 
        title: title,
        description: description,
        type: type,
        code_type: code_type
      }
    end
  end
end
