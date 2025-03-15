require 'adjustable_schema'
require 'magic/presenter'
require 'inherited_resources'
require 'slim'
require 'active_model/inherited_partials'
require 'action_dispatch/inherited_routes'
require 'rack/contrib'
require 'importmap-rails'
require 'turbo-rails'
require 'stimulus-rails'
require 'magic/core_ext/kernel/optional'

module Coniverse
	class Engine < ::Rails::Engine
		isolate_namespace Coniverse

		config.generators do
			it.test_framework = :rspec

			it.orm :active_record,
					timestamps:       false,
					primary_key_type: :uuid
		end

		initializer 'coniverse.importmap', before: 'importmap' do
			config.importmap.paths          << Engine.root/'config/importmap.rb'
			config.importmap.cache_sweepers << Engine.root/'app/javascript'
		end

		middleware.use Rack::Locale

		AdjustableSchema::Engine.config
				.actor_model_names.concat %w[
						Coniverse::Actor
				]

		class << self
			def title = 'Con!verse'

			def local_method? method
				(method.source_location or return)[0]
						.starts_with? root.to_s
			end
		end
	end

	singleton_class.delegate_missing_to Engine
end
