Rails.application.config.to_prepare do
	Magic.eager_load :models, :presenters,
			engine: Coniverse::Engine
end
