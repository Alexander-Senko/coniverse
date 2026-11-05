# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in coniverse.gemspec.
gemspec

gem 'puma'

gem 'pg'

gem 'sprockets-rails'

group :test do
	gem 'rspec-rails'
	gem 'rspec-dom-testing', require: false
	gem 'rspec-its'

	gem 'simplecov', require: false
end

group :development do
	gem 'rubocop-rails',       require: false
	gem 'rubocop-rspec',       require: false
	gem 'rubocop-rspec_rails', require: false
	gem 'brakeman',            require: false

	gem 'rbs', require: false
	gem 'rubygems-author'
end

# Start debugger with binding.b [https://github.com/ruby/debug]
# gem "debug", ">= 1.0.0"
