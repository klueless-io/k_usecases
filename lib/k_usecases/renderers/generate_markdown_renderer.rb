module KUsecases
  module Renderers
    class GenerateMarkdownRenderer < BaseRenderer
      attr_reader :file
      attr_reader :prettier
      attr_reader :open

      def initialize(metadata)
        @file = metadata[:markdown_file] || 'generate_markdown.md'
        @prettier = metadata[:markdown_prettier] || false
        @open = metadata[:markdown_open] || false
      end

      def render(documentor)
        @output = ''

        h1 documentor.title
        write_line documentor.description
        write_lf

        documentor.usecases.each { |usecase| print_usecase(usecase) }

        write_file(file)
        prettier_file(file) if prettier
        open_file_in_vscode(file) if open

        # puts @output
        # puts file
        # system "code #{file}"
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

      def h5(title)
        write_line("##### #{title}") if title != ''
      end

      def h6(title)
        write_line("###### #{title}") if title != ''
      end

      def hr
        write_line '---'
      end

      def print_usecase(usecase)
        h2 usecase.title
        write_lf

        unless usecase.usage == ''
          # h3 'Usage'
          h3 usecase.usage
          write_line usecase.usage_description
          write_lf
        end

        # if usecase.outcomes.length > 0
        #   # write_line '-' * 100
        #   h3 'Outcome'
        #   usecase.outcomes.each_with_index do |outcome|
        #     write_line "- #{outcome.description}"
        #   end
        #   write_lf
        # end

        if usecase.contents.length > 0
          
          usecase.contents.each_with_index do |content|
            
            write_line '---' if content.is_hr

            render_outcome(content) if content.type == 'outcome'
            render_code(content) if content.type == 'code'
          end
        end
      end

      def render_outcome(content)
        h4 content.title
        write_line content.summary if content.summary
      end

      def render_code(content)
        if content.code == ''
          render_code_block(content.title, content.code_type)
        else
          h4 content.title
          render_code_block(content.code, content.code_type)
        end
      end

      def render_code_block(code, code_type)
        write_line "```#{code_type}"
        write_line code
        write_line '```'
      end
   end
 end
end
