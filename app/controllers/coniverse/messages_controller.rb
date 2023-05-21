module Coniverse
	class MessagesController < ApplicationController
		belongs_to :message, optional: true

		def show
			return redirect_to [ parent, anchor: resource.id ] if
					parent

			super
		end

		private

		def message_params
			params.require(:message).permit(*%i[
					body
					lang
					title
			], {
					parent_ids: [],
			})
		end
	end
end
