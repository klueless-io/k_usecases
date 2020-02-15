# frozen_string_literal: true

module KUsecases
  # Add content from file
  module Helpers

    def uc_block_content(text, description, content_type = 'outcome')
      match_top = uc_block_content_match_top(text, content_type, description)
      if match_top.nil? || match_top[:indent].nil?
        ''
      end

      match_top_body_bottom = uc_block_content_match_top_body_bottom(text, content_type, description, match_top[:indent])
      match_top_body_bottom[:body]
    end

    def uc_block_content_match_top(text, content_type, description)
      regex = /^(?<indent>\s*)(?<content_type>#{Regexp.escape(content_type)}).*(#{Regexp.escape(description)}).*?(do)/m
      regex.match(text)
    end

    def uc_block_content_match_top_body_bottom(text, content_type, description, indent)
      regex = /^(#{indent})(?<content_type>#{Regexp.escape(content_type)}).*(#{Regexp.escape(description)}).*?(do)(?<body>.*?)(?<close_tag>(#{indent}e[123n]d))/im
      regex.match(text)
    end
  end
end