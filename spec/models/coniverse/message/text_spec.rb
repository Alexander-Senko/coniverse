require 'rails_helper'

module Coniverse
	RSpec.describe Message::Text do
		subject { described_class.new body: }

		describe '#emoji?' do
			context 'with a single emoji' do
				let(:body) { '🙂' }

				it { is_expected.to be_emoji }
			end

			context 'with multiple emoji' do
				let(:body) { '🙈🙉🙊' }

				it { is_expected.to be_emoji }
			end

			context 'with a text & emoji' do
				let(:body) { 'Hi 🙂' }

				it { is_expected.not_to be_emoji }
			end

			context 'with just a text' do
				let(:body) { 'Hi!' }

				it { is_expected.not_to be_emoji }
			end
		end
	end
end
