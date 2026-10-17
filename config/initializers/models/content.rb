# frozen_string_literal: true

ActiveSupport.on_load :model_class do
	prepend Content if
			Set[:content_type, :content_type=] <= methods
					.to_set
end
