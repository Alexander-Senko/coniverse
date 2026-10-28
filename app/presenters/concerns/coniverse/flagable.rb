# frozen_string_literal: true

module Coniverse
	concern :Flagable do
		def dom_class = Set[
				*(super if defined? super),

				*flags,
		]

		def flags = Set[
				*(flag_methods
						.select(&:call)
						.map do it
								.name
								.to_s
								.chop!
						end
				),
		]

		private

		using Module.new {
			refine Method do
				def boolean? = name.ends_with? '?'

				def parameterless? = arity.in? [ 0, -1 ]
			end
		}

		def flag_methods
			[
					self,
					__getobj__,
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
