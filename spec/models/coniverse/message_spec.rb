# frozen_string_literal: true

require 'rails_helper'

require 'models/concerns/content'
require 'models/concerns/localizable'
require 'models/concerns/coniverse/authorable'

module Coniverse
	RSpec.describe Message do
		it_behaves_like :content
		it_behaves_like :localizable
		it_behaves_like :authorable
	end
end
