
# frozen_string_literal: true

module KUsecases
  # Grab lines from content into lines array and then extract specific lines
  module Helpers
    # Grab specific lines from the content
    # 
    # Line numbers can start from start from 1
    def uc_grab_lines(content, lines_to_include)
      content_lines = content.lines

      line_nos = lines_to_include.sort.collect

      raise(StandardError, "Line numbers must start from 1") if line_nos.min < 1

      raise(StandardError, "Line number out of range - content_length: #{content_lines.length} - line_no: #{line_nos.max}") if
        content_lines.length <= line_nos.max-1

      output_lines = line_nos.map { |line_no| content_lines[line_no-1].chomp }

      output_lines.join("\n")
    end
  end
end