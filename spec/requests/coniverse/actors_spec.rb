require 'rails_helper'

module Coniverse
	RSpec.describe 'Actors' do
		include Engine.routes.url_helpers

		let(:model_class) { Actor }
		let(:model)       { model_class.first_or_create! }
	end
end
