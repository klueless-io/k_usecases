# frozen_string_literal: true

module KUsecases
  # Content code block
  class ContentCode < KUsecases::Content
    attr_accessor :code
    attr_accessor :code_type

    def self.parse(title, type, metadata)
      new(title, type, metadata) do |content|
        content.code = metadata[:code].to_s
        content.code_type = metadata[:code_type].to_s
      end
    end

    def to_h
      {
        code_type: code_type,
      }.merge(super.to_h)
    end
  end
end
