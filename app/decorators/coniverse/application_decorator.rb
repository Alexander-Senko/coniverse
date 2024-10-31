module Coniverse
	class ApplicationDecorator < Draper::Decorator
		include DOM
		include Flagable
	end
end
