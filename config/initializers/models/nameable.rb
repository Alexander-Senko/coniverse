# frozen_string_literal: true

ActiveSupport.on_load :model_class do
	include Coniverse::Nameable if
			'name_text_messages'.in? reflections
end
