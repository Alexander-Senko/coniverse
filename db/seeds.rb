# This file should contain all the record creation needed to seed the database with its default values.

module Coniverse
	# Setup model relationships
	AdjustableSchema::Relationship.module_eval do
		# Messages
		seed! Message, roles: %i[
				translation
		]

		# Actors
		seed! Actor => Message, roles: %i[
				author
				editor
		]

		seed! Message::Text => Actor, roles: %i[
				name
		]
	end
end
