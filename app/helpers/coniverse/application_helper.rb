# frozen_string_literal: true

# Multiline list items
#
# rubocop:disable Style/RedundantParentheses

module Coniverse
	module ApplicationHelper
		def title
			[
					*(Array(@title) # rubocop:disable Rails/HelperInstanceVariable
							.map { strip_tags it }
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
					lookup_context.exists? path, (path.include?('/') ? [] : lookup_context.prefixes), true
		end
	end
end
