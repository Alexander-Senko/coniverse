# frozen_string_literal: true

module Coniverse
	# = Actors controller concern
	#
	# This concern is used to set the current actor for the request.
	#
	# It looks up the actor’s ID from the request parameters or cookies and
	# sets `Current.actor`.
	concern :Actors do
		included do
			before_action :set_current_actor
		end

		private

		def actor_id
			[ # lookup
					params[:actor_id], # rubocop:disable Rails/StrongParametersExpect
					cookies.signed[:actor_id],
			].find &:present?
		end

		def set_current_actor = Current.actor_id = actor_id
	end
end
