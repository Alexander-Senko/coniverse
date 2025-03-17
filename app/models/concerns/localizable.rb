concern :Localizable do
	included do
		require 'cld'

		before_create :detect_language!, unless: :lang

		scope :for_locale, -> (locale = I18n.locale) {
			where(lang: [ locale, nil ])
					.create_with(lang: locale)
		}

		scope :localized,     -> { where.not lang: nil }
		scope :international, -> { for_locale nil }
	end

	def localized?     = lang.present?
	def international? = lang.blank?

	def lang = self[__method__]&.to_sym

	def for_locale locale = I18n.locale
		return self if lang == locale

		translations
				.for_locale(locale)
				.reorder(:lang, updated_at: :desc)
				.first or
				self
	end

	def detect_language!
		case CLD.detect_language try(:text)
		in code: 'un', reliable: true
			self.lang = nil
		in code:, reliable: true
			self.lang = code
		in code:
			self.lang ||= code
		end
	end

	def cache_key = "#{super}.#{I18n.locale}"
end
