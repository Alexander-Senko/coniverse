# frozen_string_literal: true

module Coniverse
	module DOM
		# = Enumerable DOM presenter concern
		#
		# Provides HTML DOM helpers for collections.
		module Enumerable
			def dom_class
				[
						*(try(:item_presenter)
								&.dom_class
						),

						*(self
								.map(&:class)
								.map(&:dom_class)
								.reduce(&:&)
						),
				]
			end
		end
	end
end
