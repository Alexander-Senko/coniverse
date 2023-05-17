# frozen_string_literal: true

module Coniverse
	class Message
		# = Text message
		#
		# Plain text.
		class Text < self
			delegate :to_s, to: :body

			def text = to_s

			delegate_missing_to :text

			def emoji? = match? /\A\p{Extended_Pictographic}+\Z/
		end
	end
end
