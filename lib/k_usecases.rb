# frozen_string_literal: true

require 'k_usecases/version'
require 'k_usecases/configure'
require 'k_usecases/content'
require 'k_usecases/content_code'
require 'k_usecases/content_outcome'
require 'k_usecases/documentor'
require 'k_usecases/usecase'
require 'k_usecases/renderers/base_renderer'
require 'k_usecases/renderers/generate_markdown_renderer'
require 'k_usecases/renderers/print_debug_renderer'
require 'k_usecases/renderers/print_json_renderer'
require 'k_usecases/helpers/uc_add_content'

module KUsecases
  class Error < StandardError; end
  # Your code goes here...
end
