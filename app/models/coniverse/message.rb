# frozen_string_literal: true

module Coniverse
	# = Message
	#
	# It is a core class of the Con!verse framework to represent virtually
	# any content. It is not a thing to be sent/received. Con!verse is not
	# a messanger; it is a content graph where ″everything is a message″.
	class Message < ApplicationRecord
		default_scope { order :created_at }

		store_accessor :metadata, %i[
				title
		]
	end
end
