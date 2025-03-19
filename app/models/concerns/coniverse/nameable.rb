module Coniverse
	concern :Nameable do
		delegate :to_s, to: :name_message

		def name_messages = name_text_messages
				.unscope(:order)
				.in_order_of(:lang, I18n.available_locales.including(nil))

		def name_message = name_messages
				.for_locale
				.first

		def names = name_messages
				.map(&:to_s)
				.uniq

		def name = name_message
				&.to_s

		def name= name
			name_messages.find_or_initialize_by(lang: I18n.locale)
					.body = name
		end
	end
end
