module Coniverse
	class Message
		class HTML < Text
			has_rich_text     :body
			has_many_attached :media

			def text = body.to_plain_text
		end
	end
end
