# frozen_string_literal: true

# = Localizable model concern
#
# Adds locale-aware lookup and language detection to translatable records.
# A localized record has a language; an international record has none.
concern :Localizable do
	included do
		require 'cld'

		before_create :detect_language!, unless: :lang

		# Records in the requested locale or international ones.
		scope :for_locale, -> locale = I18n.locale {
			where(lang: [ locale, nil ])
					.create_with(lang: locale)
		}

		scope :localized,     -> { where.not lang: nil }
		scope :international, -> { for_locale nil }
	end

	def localized?     = lang.present?
	def international? = lang.blank?

	def lang = self[__method__]&.to_sym

	# Record's translation for the requested locale.
	# Returns self if none found.
	def for_locale locale = I18n.locale
		return self if lang == locale

		translations
				.for_locale(locale)
				.reorder(:lang, updated_at: :desc)
				.first or
				self
	end

	# Sets the language inferred from its content.
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
