# frozen_string_literal: true

module Coniverse
	class CurrentsController < ApplicationController
		def actor
			render json: Current.actor.to_json
		end
	end
end
