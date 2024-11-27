module Coniverse
	class MessagePresenter < ApplicationPresenter
		def heading
			return unless title.present?

			link
					.tap { yield it if block_given? }
		end

		def created = created_at.tag class: 'created'
		def updated = updated_at.tag class: 'updated'

		def children(&)
			turbo_frame_tag(:messages, src: messages_path, **{
					class: 'messages',
			}, &) if messages.any?
		end

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

		def messages_path(**)
			message_messages_path(self,
					page: h.page&.settings,
			**)
		end
	end
end
