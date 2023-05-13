module InheritedResources
	module Decoratable
		def inherited controller_class
			super

			controller_class.class_eval do
				decorate_inherited :resource,   &method(:decorate)
				decorate_inherited :collection, &method(:decorate)
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

		def decorate object
			object.try :decorate or
					case object
					when Enumerable
						decorator_class.decorate_collection object
					else
						decorator_class.decorate object
					end
		rescue Draper::UninferrableDecoratorError
			object
		end

		def decorator_class
			resource_class&.decorator_class or
					ApplicationDecorator
		end
	end
end
