# frozen_string_literal: true

module KUsecases
  # Content code block
  class ContentCode < KUsecases::Content
    attr_accessor :code
    attr_accessor :code_type
    attr_accessor :summary

    def self.parse(title, type, metadata)
      new(title, type, metadata) do |content|
        content.code = metadata[:code].to_s
        content.code_type = metadata[:code_type].to_s
        content.summary = metadata[:summary].to_s
      end
    end

    def to_h
      {
        code: code,
        code_type: code_type,
        summary: summary
      }.merge(super.to_h)
    end
  end
end
