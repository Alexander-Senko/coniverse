require 'magic/core_ext/kernel/optional'

module ActionDispatch
	module InheritedRoutes
		def handle_model_call(target, record)
			super
		rescue NoMethodError
			record = record
					.optional { it.try :__getobj__ } # decorated
					.class.superclass
					.optional { raise if it.abstract_class? }
					.then     { record.becomes it }
			retry
		end
	end

	Routing::PolymorphicRoutes::HelperMethodBuilder.prepend InheritedRoutes
end
