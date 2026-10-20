# frozen_string_literal: true

Rails.application.config.to_prepare do
	Magic.eager_load :models,
			engine: Coniverse::Engine
end
