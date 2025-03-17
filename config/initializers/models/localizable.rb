ActiveSupport.on_load :model_class do
	next unless table_exists?

	include Localizable if
			'lang'.in? column_names
end
