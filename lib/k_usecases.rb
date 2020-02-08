# frozen_string_literal: true

require 'k_usecases/version'
require 'k_usecases/content_block'
require 'k_usecases/documentor'
require 'k_usecases/outcome'
require 'k_usecases/usecase'
require 'k_usecases/renderers/base_renderer'
require 'k_usecases/renderers/generate_markdown_renderer'
require 'k_usecases/renderers/print_debug_renderer'
require 'k_usecases/renderers/print_json_renderer'

module KUsecases
  class Error < StandardError; end
  # Your code goes here...
end
