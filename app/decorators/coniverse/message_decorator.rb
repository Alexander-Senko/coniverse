module Coniverse
	class MessageDecorator < ApplicationDecorator
		delegate_all

		decorates_association :messages

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

		def tag(*, **options, &)
			h.content_tag(tag_name, *,
					id:,
					lang:,
					class: [
							html_class,
							options.delete(:class),
					].flat_map { Array.wrap _1 },
			**options, &)
		end

		private

		def tag_name = :article
	end
end
