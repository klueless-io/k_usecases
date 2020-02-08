# frozen_string_literal: true

module KUsecases
  # Outcome
  class Outcome
    attr_reader :description

    def self.parse(example)
      return nil if example.description.nil? || example.description.strip.length == 0
      return nil if example.metadata[:content_block] && example.metadata[:content_block] == true

      Outcome.new(example.description) 
    end

    def initialize(description)
      @description = description
    end

    def to_h
      { 
        description: description
      }
    end
  end
end
