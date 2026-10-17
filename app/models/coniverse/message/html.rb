# frozen_string_literal: true

module Coniverse
	class Message
		# = HTML message
		#
		# Rich text in HTML format with optional media attachments.
		class HTML < Text
			self.content_type = 'text/html'

			has_rich_text     :body
			has_many_attached :media

			def text = body.to_plain_text
		end
	end
end
