
# frozen_string_literal: true

module KUsecases
  # Add content from file
  module Helpers
    def uc_add_content(filename, **args)
      content = File.read(filename)

      content = uc_content_lines(content, args[:lines]) if args[:lines]
      content = "```#{args[:code_type]}\n#{content}\n```" unless args[:code_type].nil?
      content
    end

    def uc_content_lines(content, lines_to_include)
      content_lines = content.lines

      output_lines = lines_to_include.sort.collect do |line_no|
        raise(StandardError, "Line number out of range - content_length: #{content_lines.length} - line_no: #{line_no}") if
          content_lines.length < line_no

        content_lines[line_no].chomp
      end

      output_lines.join("\n")
    end
  end
end