module ActionDispatch
	module InheritedRoutes
		def initialize(...)
			super

			ancestor_models
					.map(&:model_name)
					.find { helpers.respond_to? :"#{it.route_key}_url" }
					&.then do
						@route_key          = it.route_key
						@singular_route_key = it.singular_route_key
					end
		end

		private

		def ancestor_models
			@klass.ancestors
					.grep(@klass.superclass...ActiveRecord::Base)
		end

		def routes  = engine.routes
		def helpers = routes.url_helpers

		def engine
			ancestor_models # using heuristics
					.last
					.name
					.deconstantize
					.then { "#{it}::Engine" }
					.safe_constantize
					.then { it or Rails.application }
		end
	end

	ActiveModel::Name.prepend InheritedRoutes
end
