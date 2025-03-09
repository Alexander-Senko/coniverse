require_relative "lib/coniverse/version"
require_relative 'lib/coniverse/authors'

Gem::Specification.new do |spec|
  spec.platform    = Gem::Platform::RUBY
  spec.name        = "coniverse"
  spec.version     = Coniverse::VERSION
  spec.authors     = Coniverse::AUTHORS.names
  spec.email       = Coniverse::AUTHORS.emails
  spec.homepage    = "#{Coniverse::AUTHORS.github_url}/#{spec.name}"
  spec.summary     = 'Everything is a message!'
  spec.description = 'A Rails Engine to connect all of your knowledge together.'
  spec.license     = "MIT"

  spec.metadata["homepage_uri"]    = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"]   = "#{spec.metadata['source_code_uri']}/blob/v#{spec.version}/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md", 'CHANGELOG.md']
  end

  spec.required_ruby_version = '>= 3.4'

  spec.add_dependency 'rails', '>= 7.1'

  # Models
  spec.add_dependency 'adjustable_schema', '~> 0.8'

  # Views
  spec.add_dependency 'slim-rails'
  spec.add_dependency 'magic-presenter'
  spec.add_dependency 'active_model-inherited_partials'

  # Controllers
  spec.add_dependency 'inherited_resources'

  # Front end
  spec.add_dependency 'importmap-rails'
  spec.add_dependency 'turbo-rails'
  spec.add_dependency 'stimulus-rails'
end
