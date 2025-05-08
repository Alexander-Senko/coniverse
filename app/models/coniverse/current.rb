# frozen_string_literal: true

module Coniverse
	class Current < ActiveSupport::CurrentAttributes # :nodoc:
		attribute :actor

		def actors
			[ # lookup
					Actor.all,
			].find(&:itself)
			# TODO: restrict to ex. `User.actors`
		end

		def actor_id= actor_id
			self.actor = actor_id
					&.then { actors.find it }
		end
	end
end
