module KUsecases
  module Renderers
    class GenerateMarkdownRenderer < BaseRenderer
      attr_reader :file

      def initialize(metadata)
        @file = metadata[:markdown_file] || 'generate_markdown.md'
      end

      def render(documentor)
        @output = ''

        h1 documentor.title
        write_line documentor.description
        write_lf

        documentor.usecases.each { |usecase| print_usecase(usecase) }

        # puts @output
        puts file
        File.write(file, @output)
        system "code #{file}"
      end

      def h1(title)
        write_line("# #{title}") if title != ''
      end

      def h2(title)
        write_line("## #{title}") if title != ''
      end

      def h3(title)
        write_line("### #{title}") if title != ''
      end

      def h4(title)
        write_line("#### #{title}") if title != ''
      end

      def print_usecase(usecase)
        h2 usecase.title
        write_lf

        unless usecase.usage == ''
          h3 'Usage'
          write_line usecase.usage
          write_lf
        end

        if usecase.outcomes.length > 0
          # write_line '-' * 100
          h3 'Outcome'
          usecase.outcomes.each_with_index do |outcome|
            write_line "- #{outcome.description}"
          end
          write_lf
        end

        if usecase.content_blocks.length > 0
          
          usecase.content_blocks.each_with_index do |content_block|
            write_line '---'

            h3 content_block.title

            if content_block.code_type == ''
              write_line content_block.description
            else
              write_line "```#{content_block.code_type}"
              write_line content_block.description
              write_line '```'
            end
            # write_line "Type        : #{content_block.type}" if content_block.type
            # write_line "Code Type   : #{content_block.code_type}" if content_block.code_type
          end
        end
      end
    end
  end
end
