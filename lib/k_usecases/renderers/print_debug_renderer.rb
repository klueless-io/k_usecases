module KUsecases
  module Renderers
    class PrintDebugRenderer < BaseRenderer
      def initialize(metadata)
      end

      def render(documentor)
        @output = ''
        write_line '*' * 100
        write_line "Title             : #{documentor.title}" if documentor.title
        write_line "Description       : #{documentor.description}" if documentor.description
        documentor.usecases.each { |usecase| print_usecase(usecase) }
        puts @output
      end

      def print_usecase(usecase)
        write_line '=' * 100
        write_line "Key               : #{usecase.key}" if usecase.key
        write_line "Title             : #{usecase.title}" if usecase.title
        write_line "Usage             : #{usecase.usage}" if usecase.usage
        write_line "Usage Description : #{usecase.usage_description}" if usecase.usage_description

        if usecase.contents.length > 0
          usecase.contents.each_with_index do |content|
            write_line '-' * 100
            write_line "Title             : #{content.title}" if content.title != ''
            write_line "Type              : #{content.type}" if content.type != ''

            # Used by outcome
            write_line "Summary           : #{content.summary}" if content.respond_to?('summary') && content.summary != ''

            # Used by code
            write_line "Code              : #{content.code}" if content.respond_to?('code') && content.code != ''
            write_line "Code Type         : #{content.code_type}" if content.respond_to?('code_type') && content.code_type != ''
          end
        end
      end
    end
  end
end
