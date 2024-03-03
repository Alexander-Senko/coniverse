# frozen_string_literal: true

module Coniverse
	class ConversationPresenter < Message::HTMLPresenter
		def dom_class
			[
					*super,

					*{
							1    => 'monologue',
							2    => 'dialogue',
							3... => 'group',
					}.select { it === actors.size }.values,
			]
		end
	end
end
