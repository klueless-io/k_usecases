module KUsecases
  module Renderers
    class PrintJsonRenderer
      def initialize(metadata)
      end

      def render(documentor)
        puts JSON.pretty_generate({
          document: {
            title: documentor.title,
            description: documentor.description
          },
          usecases: documentor.usecases.map { |usecase| usecase.to_h } })
      end
    end
  end
end
