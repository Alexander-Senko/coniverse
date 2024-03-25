require 'rails_helper'

require 'controllers/concerns/pageable'

module Coniverse
	RSpec.describe MessagesController do
		routes { Engine.routes }

		it_behaves_like 'pageable controller'
	end
end
