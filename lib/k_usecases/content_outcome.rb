# frozen_string_literal: true

module KUsecases
  # Content outcome
  class ContentOutcome < KUsecases::Content
    attr_accessor :summary

    def self.parse(title, type, metadata)
      new(title, type, metadata) do |content|
        content.summary = metadata[:summary].to_s
      end
    end

    def to_h
      {
        summary: summary
      }.merge(super.to_h)
    end
  end
end
