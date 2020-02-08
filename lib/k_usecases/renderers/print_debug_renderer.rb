module KUsecases
  module Renderers
    class PrintDebugRenderer < BaseRenderer
      def initialize(metadata)
      end

      def render(documentor)
        @output = ''
        write_line '*' * 100
        write_line "Title       : #{documentor.title}" if documentor.title
        write_line "Description : #{documentor.description}" if documentor.description
        documentor.usecases.each { |usecase| print_usecase(usecase) }
        puts @output
      end

      def print_usecase(usecase)
        write_line '=' * 100
        write_line "Key         : #{usecase.key}" if usecase.key
        write_line "Title       : #{usecase.title}" if usecase.title
        write_line "Usage       : #{usecase.usage}" if usecase.usage

        if usecase.outcomes.length > 0
          write_line '-' * 100
          usecase.outcomes.each_with_index do |outcome|
            write_line "Outcome     : #{outcome.description}" if outcome.description
          end
        end

        if usecase.content_blocks.length > 0
          usecase.content_blocks.each_with_index do |content_block|
            write_line '-' * 100
            write_line "Title       : #{content_block.title}" if content_block.title
            write_line "Description : #{content_block.description}" if content_block.description
            write_line "Type        : #{content_block.type}" if content_block.type
            write_line "Code Type   : #{content_block.code_type}" if content_block.code_type
          end
        end
      end
    end
  end
end
