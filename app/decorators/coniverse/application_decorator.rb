module Coniverse
	class ApplicationDecorator < Draper::Decorator
		class << self
			def html_class
				[
						*(ancestors
								.grep(superclass...ApplicationDecorator)
								.flat_map(&__method__)
						),

						*(model_name
								.unnamespaced
								.underscore
								.split('/')
								.map(&:pluralize)
						),
				].uniq
			end
		end

		def html_class
			[
					*(self.class.html_class
							.map(&:singularize)
					),

					*flags,
			].uniq
		end

		def flags
			[
					*(flag_methods
							.select(&:call)
							.map do it
								.name
								.to_s
								.chop!
							end
					),
			]
		end

		private

		using Module.new {
			refine Method do
				def boolean? = name.ends_with? '?'

				def parameterless? = arity.in? [0, -1]
			end
		}

		def flag_methods
			[
					self,
					object,
			]
					.flat_map { it
							.public_methods
							.map(&it.method(:method))
					}
					.select(&:boolean?)
					.select(&:parameterless?)
					.select { Engine.local_method? it }
		end
	end
end
