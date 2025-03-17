# frozen_string_literal: true

require 'rails_helper'

require 'models/concerns/localizable'

module Coniverse
	RSpec.describe Message do
		it_behaves_like :localizable
	end
end
