# frozen_string_literal: true

require_relative 'lib/k_usecases/version'

Gem::Specification.new do |spec|
  spec.name          = 'k_usecases'
  spec.version       = KUsecases::VERSION
  spec.authors       = ['David']
  spec.email         = ['david@ideasmen.com.au']

  spec.summary       = 'Usecases &#x27;k_usecases&#x27; is a gem for documenting ruby code usecases from rspec'
  spec.description   = 'Usecases &#x27;k_usecases&#x27; is a gem for documenting ruby code usecases from rspec'
  spec.homepage      = 'http://appydave.com/gems/k_usecases'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  # spec.metadata['allowed_push_host'] = "Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/klueless-io/k_usecases'
  spec.metadata['changelog_uri'] = 'https://github.com/klueless-io/k_usecases/commits/master'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the RubyGem files that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.extensions    = ['ext/k_usecases/extconf.rb']

  # spec.add_dependency 'tty-box',         '~> 0.5.0'
end
