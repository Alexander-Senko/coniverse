# frozen_string_literal: true

require 'bundler/setup'

APP_RAKEFILE = File.expand_path('spec/dummy/Rakefile', __dir__)
load 'rails/tasks/engine.rake'

require 'bundler/gem_tasks'

begin
	require 'rspec/core/rake_task'

	# Presenters: specs run in a separate process for the models loaded by
	# 	other specs not to mask model lookup failures.
	groups = %w[
			presenters
	].then do |types|
		types << types.map { "-#{it}" } * ','
	end

	RSpec::Core::RakeTask.new :spec, :type do |task, args|
		case args
		in type:
			type.match(/^(-)?(\w+)$/) => exclude, type

			ENV['SPEC_GROUP'] = args[:type]

			task.rspec_opts = <<~SH.squish
				--#{'exclude-' if exclude}pattern 'spec/#{type.pluralize}/**/*_spec.rb'
			SH
		else # all specs
		end
	end

	namespace :spec do
		task :groups do # rubocop:disable Rails/RakeEnvironment
			for type in groups do
				Rake::Task[:spec].reenable
				Rake::Task[:spec].invoke type
			end
		end
	end

	task default: 'spec:groups'
rescue LoadError
	# no rspec available
end
