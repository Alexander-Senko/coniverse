module InheritedResources
	module Decoratable
		def inherited controller_class
			super

			controller_class.class_eval do
				decorate_inherited :resource,   &:decorated
				decorate_inherited :collection, &:decorated
			end
		end

		protected

		def decorate_inherited method, &decorator
			prepend Module.new {
				protected

				define_method method do
					send "get_#{method}_ivar" or # cache
							send "set_#{method}_ivar", instance_exec(super(), &decorator)
				end
			}
		end
	end
end
