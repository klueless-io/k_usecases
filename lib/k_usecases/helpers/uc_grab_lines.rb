
# frozen_string_literal: true

module KUsecases
  # Grab lines from content to lines and then extrat specific lines
  module Helpers
    # Grab specific lines from the content
    # 
    # Line numbers can start from start from 1
    def uc_grab_lines(content, lines_to_include)
      content_lines = content.lines

      output_lines = lines_to_include.sort.collect do |line_no|
        raise(StandardError, "Line number out of range - content_length: #{content_lines.length} - line_no: #{line_no}") if
          content_lines.length < (line_no-1)

        content_lines[line_no-1].chomp
      end

      output_lines.join("\n")
    end
  end
end