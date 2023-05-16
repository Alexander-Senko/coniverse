require 'draper'
require 'inherited_resources'
require 'slim'
require 'active_model/inherited_partials'

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
	end
end
