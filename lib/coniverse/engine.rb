require 'adjustable_schema'
require 'draper'
require 'inherited_resources'
require 'slim'
require 'active_model/inherited_partials'
require 'importmap-rails'

module Coniverse
	class Engine < ::Rails::Engine
		isolate_namespace Coniverse

		config.generators do
			_1.test_framework = :rspec
			_1.helper         = false

			_1.orm :active_record,
					timestamps:       false,
					primary_key_type: :uuid
		end

		initializer 'coniverse.importmap', before: 'importmap' do
			config.importmap.paths          << Engine.root/'config/importmap.rb'
			config.importmap.cache_sweepers << Engine.root/'app/javascript'
		end

		class << self
			def local_method? method
				(method.source_location or return)[0]
						.starts_with? root.to_s
			end
		end
	end
end
