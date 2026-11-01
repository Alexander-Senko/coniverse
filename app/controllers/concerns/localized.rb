# frozen_string_literal: true

# = Localized controller concern
#
# This concern is used to set the locale for controller actions.
#
# Locale is determined based on (in order of precedence):
# * an explicit request `locale` parameter,
# * browser settings (via `Accept-Language` header),
# * `I18n`.
concern :Localized do
	include Memery

	included do
		around_action :with_locale
	end

	private

	memoize def locale
		[ # sources
				*params[:locale], # rubocop:disable Rails/StrongParametersExpect
				*request.env['rack.locale'],
				I18n.locale,
		]
				.find { I18n.locale_available? it }
				&.to_sym
	end

	def with_locale(&) = I18n.with_locale locale, &
end
