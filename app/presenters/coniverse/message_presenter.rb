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
	end
end
