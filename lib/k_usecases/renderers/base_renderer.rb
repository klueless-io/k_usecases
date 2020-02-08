module KUsecases
  module Renderers
    class BaseRenderer
      def write_line(line = nil)
        @output = "#{@output}#{line}\n" unless line == ''
      end
      def write_lf(line = nil)
        @output = "#{@output}\n"
      end
    end
  end
end
