# frozen_string_literal: true

module Coniverse
	# = Flagable presenter concern
	#
	# Provides boolean flag helpers.
	concern :Flagable do
		# Adds flags
		def dom_class
			[
					*(super if defined? super),

					*flags,
			].uniq
		end

		# Returns all the flags detected, based on:
		# * public instance methods
		def flags
			[
					*(flag_methods
							.select(&:call)
							.map do it # rubocop:disable Layout
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

				def parameterless? = arity.in? [ 0, -1 ]
			end
		}

		def flag_methods
			[
					self,
					__getobj__,
			]
					.flat_map { it # rubocop:disable Layout
							.public_methods
							.map(&it.method(:method))
					}
					.select(&:boolean?)
					.select(&:parameterless?)
					.select { Engine.local_method? it }
		end
	end
end
