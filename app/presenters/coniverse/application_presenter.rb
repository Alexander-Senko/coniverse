# frozen_string_literal: true

module Coniverse
	class ApplicationPresenter < Magic::Presenter::Base
		include DOM
		include Linkable
		include Flagable
	end
end
