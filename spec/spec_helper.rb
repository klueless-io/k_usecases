# frozen_string_literal: true

require 'pry'
require 'bundler/setup'
require 'k_usecases'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'
  config.filter_run_when_matching :focus

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # ----------------------------------------------------------------------
  # Usecase Documentator
  # ----------------------------------------------------------------------

  config.alias_example_group_to :usecase, usecase: true

  config.extend KUsecases

  # config.include KUsecases
  config.before(:context, :usecases) do
    # puts self.class.children

    # puts '# -children-------------------------------------------------------------'
    # puts self.class.children
    # puts '# -children.first.children----------------------------------------------'
    # puts self.class.children.first.children
    # puts '# -children.first.children.first.examples-------------------------------'
    # puts self.class.children.first.children.first.examples
    # puts '# -descendants----------------------------------------------------------'
    # puts self.class.descendants
    # puts '# -descendants.first.metadata-------------------------------------------'
    # puts self.class.descendants.first.metadata
    # puts '# -filtered_examples----------------------------------------------------'
    # puts self.class.filtered_examples
    # puts '# -parent_groups--------------------------------------------------------'
    # puts self.class.parent_groups
    # puts '# ----------------------------------------------------------------------'

    @usecases = KUsecases::Usecases.new(self.class) if self.class.metadata[:usecases] == true
    puts JSON.pretty_generate(@usecases.to_h)
    # @usecases.debug
  end

end
