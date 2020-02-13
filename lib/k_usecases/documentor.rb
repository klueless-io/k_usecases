# frozen_string_literal: true

module KUsecases
  # Documentor is the main entry point for documenting usecases
  # in RSpec.
  # 
  # A singlton instance handles configuration and use case
  # management within a running :context
  class Documentor
    attr_reader :usecases
    attr_reader :renderers
    
    attr_reader :title
    attr_reader :description

    attr_reader :render_json
    attr_reader :render_debug
    attr_reader :render_generate_markdown

    def initialize(root_example_group)
      @root = root_example_group

      build_settings

      build_usecases
      build_renderers
    end

    def render
      @renderers.each do |renderer|
        renderer.render(self)
      end
    end

    def to_h
      {
        usecases: @usecases.map { |usecase| usecase.to_h },
        renderers: @renderers.map { |renderer| renderer.class.name }
      }
    end

    private

    def build_settings
      @title = @root.metadata[:document_title] || ''
      @description = @root.metadata[:document_description] || ''

      @render_json = @root.metadata[:json] && @root.metadata[:json] == true
      @render_debug = @root.metadata[:debug] && @root.metadata[:debug] == true
      @render_generate_markdown = @root.metadata[:markdown] && @root.metadata[:markdown] == true
    end

    def build_usecases
      @usecases = []

      return unless @root.metadata[:usecases]

      # Get a list of describe or context blocks with the :usecase
      # metadata flag, or use `usecase 'xyz' do end` in your code.
      usecases = @root.descendants.select { |d| d.metadata[:usecase] == true }

      @usecases = usecases.map { |usecase| Usecase.parse(usecase.name, usecase) }
    end

    def build_renderers
      @renderers = []
      @renderers << KUsecases::Renderers::PrintJsonRenderer.new(@root.metadata) if @render_json
      @renderers << KUsecases::Renderers::PrintDebugRenderer.new(@root.metadata) if @render_debug
      @renderers << KUsecases::Renderers::GenerateMarkdownRenderer.new(@root.metadata) if @render_generate_markdown
    end
  end
end
