module Coniverse
	class CollectionDecorator < Draper::CollectionDecorator
		def dom_class
			[
					*(decorator_classes
							.map(&:dom_class)
							.reduce(&:&)
					),
			]
		end

		private

		def decorator_classes
			Array.wrap decorator_class ||
					map(&:decorator_class)
		end
	end
end
