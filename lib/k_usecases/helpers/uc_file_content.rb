
# frozen_string_literal: true

module KUsecases
  # Add content from file
  module Helpers
    def uc_file_content(filename, **args)
      content = File.read(filename)

      content = uc_grab_lines(content, args[:lines]) if args[:lines]

      # To Deprecate: It may not be smart to suppor the code_type arg
      #               it is probabally better to pass content into markdown 
      #               components in raw format and let them apply this value
      content = "```#{args[:code_type]}\n#{content}\n```" unless args[:code_type].nil?
      content
    end
  end
end