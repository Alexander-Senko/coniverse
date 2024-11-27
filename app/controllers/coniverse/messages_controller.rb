module Coniverse
	class MessagesController < ApplicationController
		prepend Pageable

		belongs_to :message, optional: true

		page.size = 20

		def show
			return redirect_to [ parent, anchor: resource.id ] if
					parent

			super
		end

		private

		def collection
			super
					.optional { it.independent unless parent }
		end

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
