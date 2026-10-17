# frozen_string_literal: true

require 'rails_helper'

require 'models/concerns/content'

module Coniverse
	RSpec.describe Message::HTML do
		subject { described_class.new body: }

		it_behaves_like :content

		describe '#emoji?' do
			context 'with emoji and some markup' do
				let(:body) { '<p>🙂</p>' }

				its_result { is_expected.to be true }
			end
		end
	end
end
