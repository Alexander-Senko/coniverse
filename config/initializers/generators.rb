engine_generators = Coniverse::Engine.config.generators

Rails.application.config.generators do
	it.orm :active_record,
			primary_key_type: engine_generators.options[engine_generators.orm][:primary_key_type]
end
