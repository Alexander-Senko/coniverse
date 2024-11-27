module Coniverse
	class MessagePresenter < ApplicationPresenter
		def heading
			return unless title.present?

			link
					.tap { yield it if block_given? }
		end

		def created = created_at.tag class: 'created'
		def updated = updated_at.tag class: 'updated'

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
