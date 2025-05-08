# frozen_string_literal: true

module Coniverse
	# = Actor
	#
	# This model represents an actor in the system, which’s roles are:
	# * to author messages and their modifications,
	# * to participate in conversations.
	class Actor < ApplicationRecord
		def current? = self == Current.actor

		def available? = in? Current.actors
	end
end
