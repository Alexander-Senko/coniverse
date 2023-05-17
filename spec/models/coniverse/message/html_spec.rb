require 'rails_helper'

module Coniverse
	RSpec.describe Message::HTML do
		subject { described_class.new body: }

		describe '#emoji?' do
			context 'with emoji and some markup' do
				let(:body) { '<p>🙂</p>' }

				it { is_expected.to be_emoji }
			end
		end
	end
end
