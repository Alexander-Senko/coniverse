require 'slim'

module Coniverse
	class Engine < ::Rails::Engine
		isolate_namespace Coniverse

		config.generators do
			_1.test_framework = :rspec
		end
	end
end
