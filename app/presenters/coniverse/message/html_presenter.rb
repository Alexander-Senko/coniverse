module Coniverse
	class Message
		class HTMLPresenter < TextPresenter
			def title = sanitize super
		end
	end
end
