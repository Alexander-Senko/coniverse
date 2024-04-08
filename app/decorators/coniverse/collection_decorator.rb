module Coniverse
	class CollectionDecorator < Draper::CollectionDecorator
		def html_class
			[
					*(decorator_classes
							.map(&:html_class)
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
