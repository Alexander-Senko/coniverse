module Coniverse
	class MessagePresenter < ApplicationPresenter
		def flat?
			return if messageless?

			[ # conditions
					intermediate?,
					messages.all?(&:messageless?),
			].any?
		end

		def tree?
			return if messageless?

			not flat?
		end

		private

		def tag_name = :article
	end
end
