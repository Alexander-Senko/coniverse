Rails.application.config.to_prepare do
	Enumerable.include Magic::Presentable
end
