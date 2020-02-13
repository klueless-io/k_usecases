# frozen_string_literal: true

module KUsecases
  # Content block
  class Content
    attr_reader :title
    attr_reader :type
    attr_reader :metadata

    attr_reader :is_hr

    def self.parse(example)

      return nil if example.description.nil? || example.description.strip.length == 0
      return nil if example.metadata[:content_type].nil?

      title = example.description
      type = example.metadata[:content_type].to_s
      metadata= example.metadata

      klass = "KUsecases::Content#{type.capitalize}"
      
      begin
        content_object = "#{klass}.parse(title, type, example.metadata)"
        # puts content_object
        eval(content_object)
      rescue => exception
        puts "UNKNOWN CONTENT TYPE: #{example.metadata[:content_type]}"
        nil
      end
    end

    def initialize(title, type, metadata)
      @title = title.start_with?('example at .') ? '' : title
      @type = type

      @is_hr = !!metadata[:hr]

      yield self if block_given?
    end

    def to_h
      { 
        title: title,
        type: type,
        options: [
          is_hr: is_hr 
        ]
      }
    end
  end
end
