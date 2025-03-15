require 'rails_helper'

require 'models/concerns/coniverse/nameable'

module Coniverse
	RSpec.describe Actor do
		it_behaves_like 'nameable model'
	end
end
