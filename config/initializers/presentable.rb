Rails.application.config.to_prepare do
	[ # presentable classes
			Enumerable,
			ActiveSupport::TimeWithZone,
	].each { it.include Magic::Presentable }
end
