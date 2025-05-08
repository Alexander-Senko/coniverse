# frozen_string_literal: true

module Coniverse
	class ActorsController < ApplicationController
		prepend_after_action :set_current_actor,
				only: %i[ set_current unset_current ]

		def set_current
			cookies.signed[:actor_id] = params[:id]
					.then { Actor.find it }.id # check

			reload_page
		end

		def unset_current
			cookies.delete :actor_id if
					actor_id == params[:id] # check

			reload_page
		end
	end
end
