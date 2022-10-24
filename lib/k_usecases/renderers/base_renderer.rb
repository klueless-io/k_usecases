module KUsecases
  module Renderers
    class BaseRenderer
      def write_line(line = nil)
        @output = "#{@output}#{line}\n" unless line == ''
      end
      def write_lf(line = nil)
        @output = "#{@output}\n"
      end

      def write_file(file)
        FileUtils.mkdir_p(File.dirname(file))

        File.write(file, @output)
      end

      def prettier_file(file)
        # npm install -g prettier @prettier/plugin-ruby

        cmd = "prettier --check #{file} --write #{file}"

        puts cmd
        system(cmd)
      end

      def open_file_in_vscode(file)
        system("code #{file}")
      end
    end
  end
end
