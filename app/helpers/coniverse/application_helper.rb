module Coniverse
	module ApplicationHelper
		def title
			[
					*(Array(@title)
							.map { strip_tags it }
							.map(&:presence)
					),

					Engine.title,
			]
					.compact
					.uniq
					.join(' — ')
		end
	end
end
