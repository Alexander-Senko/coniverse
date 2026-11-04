# frozen_string_literal: true

ActiveSupport.on_load :presentable do
	class << self
		include Memery

		memoize def classes(...)
			Magic.eager_load :models,
					engine: Coniverse::Engine

			super
		end
	end
end
