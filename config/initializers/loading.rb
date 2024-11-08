Rails.application.config.to_prepare do
	Magic.eager_load :presenters,
			engine: Coniverse::Engine
end
