# frozen_string_literal: true

# Multiline list items
#
# rubocop:disable Style/RedundantParentheses
# rubocop:disable Style/RedundantSelf

module Coniverse
	module DOM
		# = Enumerable DOM presenter concern
		#
		# Provides HTML DOM helpers for collections.
		module Enumerable
			def dom_class = Set[
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
