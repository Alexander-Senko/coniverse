concern :Localized do
	include Memery

	included do
		around_action :with_locale
	end

	private

	memoize def locale
		[ # sources
				params[:locale],
				request.env['rack.locale'],
				I18n.locale,
		]
				.find { I18n.locale_available? it }
				&.to_sym
	end

	def with_locale(&) = I18n.with_locale locale, &
end
