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

		def render_if_exists path
			render path if
					lookup_context.exists? path, (path.include?(?/) ? [] : @lookup_context.prefixes), true
		end
	end
end
