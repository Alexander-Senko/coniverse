module Coniverse
	class Message < ApplicationRecord
		default_scope { order :created_at }

		store_accessor :metadata, %i[
				title
		]

		scope :independent, -> do
			where.missing(:parents)
					.roleless
		end
	end
end
