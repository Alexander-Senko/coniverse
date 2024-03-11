module Coniverse
	class ApplicationRecord < ActiveRecord::Base
		using UUID

		self.abstract_class = true

		# Converts arbitrary IDs to persistent UUIDs based on current UUID namespace.
		def id= id
			super id.to_uuid
		end
	end
end
