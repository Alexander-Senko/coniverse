require_relative "lib/coniverse/version"
require_relative 'lib/coniverse/authors'

Gem::Specification.new do |spec|
  spec.platform    = Gem::Platform::RUBY
  spec.name        = "coniverse"
  spec.version     = Coniverse::VERSION
  spec.authors     = Coniverse::AUTHORS.filter_map &:name
  spec.email       = Coniverse::AUTHORS.filter_map &:email
  spec.homepage    = "#{Coniverse::AUTHORS.filter_map(&:github_url).first}/#{spec.name}"
  spec.summary     = 'Everything is a message!'
  spec.description = 'A Rails Engine to connect all of your knowledge together.'
  spec.license     = "MIT"

  spec.metadata["homepage_uri"]    = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"]   = "#{spec.metadata['source_code_uri']}/blob/v#{spec.version}/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md", 'CHANGELOG.md']
  end

  spec.required_ruby_version = '>= 3.2'

  spec.add_dependency 'rails', '~> 7.1'

  # Views
  spec.add_dependency 'slim-rails'
end
