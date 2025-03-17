# frozen_string_literal: true

ActiveSupport.on_load :model_class do
	next unless base_class?
	next unless table_exists?

	include Coniverse::Authorable if
			%i[
					authors
					editors
			].any? { method_defined? it }
end
