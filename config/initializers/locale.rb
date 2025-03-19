ActiveSupport.on_load :model_class do
	next unless self < Localizable

	I18n.available_locales |=
			self
					.unscoped
					.localized
					.distinct.pluck :lang
end
