module Coniverse
	module ApplicationHelper
		def title
			[
					*(Array(@title)
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
