# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.

module Coniverse
	# Setup model relationships
	AdjustableSchema.module_eval do
		# Messages
		relationship! Message, roles: %i[
				translation
		]

		# Actors
		relationship! Actor => Message, roles: %i[
				author
				editor
		]

		relationship! Message::Text => Actor, roles: %i[
				name
		]
	end
end
