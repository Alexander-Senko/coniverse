module Coniverse
	module DOM
		module Enumerable
			def dom_class
				[
						*(self
								.map(&:class)
								.map(&:dom_class)
								.reduce(&:&)
						),
				]
			end
		end
	end
end
