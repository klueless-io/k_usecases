# frozen_string_literal: true

module KUsecases
  # Content block
  class Content
    EXTRACT_CONTENT_REX = /
      ^                                     # begining of string
      (?<indent>\s*)                        # find the indent before the method
    
      (?<method_type>(outcome|code|ruby)\s) # grab the method name from predefined list
      (?<method_signature>.*?)              # grab the method signature which is every thing up to the first do
      (do)                                  # code comes after the first do
      (?<content>.*)                        # content is what we want
      (?<method_closure>end)\z              # the end keyword at the end of string is where the content finishes
    /xm

    attr_reader :title
    attr_reader :type
    attr_reader :metadata
    attr_reader :source

    attr_reader :is_hr

    def self.parse(example)

      return nil if example.description.nil? || example.description.strip.length == 0
      return nil if example.metadata[:content_type].nil?

      title = example.description
      type = example.metadata[:content_type].to_s
      metadata = example.metadata

      klass = "KUsecases::Content#{type.capitalize}"
      
      begin
        content_object = "#{klass}.parse(title, type, example.metadata)"
        result = eval(content_object)
        result
      rescue => exception
        puts "UNKNOWN CONTENT TYPE: #{example.metadata[:content_type]}"
        result = nil
      end

      begin
        result.parse_block_source(example) if result
      rescue => exception
        puts "Could not parse source"
        puts example.metadata
        puts exception
      end
      result
    end

    def initialize(title, type, metadata)
      @title = title.start_with?('example at .') ? '' : title
      @type = type

      @is_hr = !!metadata[:hr]

      yield self if block_given?
    end

    # Have not write a test for this yet
    def parse_block_source(example)
      # Source code for rspec is living on the metadata[:block].source location
      unless defined?(example.metadata) && defined?(example.metadata[:block]) && defined?(example.metadata[:block].source)
        @source = ''
        return
      end
      
      source = example.metadata[:block].source.strip

      segments = source.match(EXTRACT_CONTENT_REX)

      unless defined?(segments) && defined?(segments[:content])
        @source = ''
        return
      end
      @source = remove_wasted_indentation(segments[:content])
    end

    def remove_wasted_indentation(content)
      lines = content.lines

      whitespace = /^\s*/

      # find the small whitespace sequence 
      # at beginning of line that is not \n or blank
      # and grap the smallest value
      indent = lines
        .map    { |l| l.match(whitespace).to_s }
        .reject { |s| s == "\n" || s == '' }
        .min_by(&:length)

      # remove the smallet indentation from beginning 
      # of all lines, this is the wasted indentation
      rex_indent = /^#{indent}/

      lines = lines.map { |l| l.gsub!(rex_indent, '') }

      # convert back to a content string
      lines.join.strip
    end

    def to_h
      { 
        title: title,
        type: type,
        source: source,
        options: [
          is_hr: is_hr 
        ]
      }
    end
  end
end
