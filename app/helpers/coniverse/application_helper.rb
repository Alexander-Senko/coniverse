module Coniverse
	module ApplicationHelper
		def render_if_exists path
			render path if
					lookup_context.exists? path, (path.include?(?/) ? [] : @lookup_context.prefixes), true
		end
	end
end
