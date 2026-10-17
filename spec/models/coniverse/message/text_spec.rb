# frozen_string_literal: true

require 'rails_helper'

require 'models/concerns/content'

module Coniverse
	RSpec.describe Message::Text do
		subject { described_class.new body: }

		it_behaves_like :content do
			let(:content_types) { %w[
					text/plain
					text/markdown
			] }
		end

		describe '#emoji?' do
			context 'with a single emoji' do
				let(:body) { '🙂' }

				its_result { is_expected.to be true }
			end

			context 'with multiple emoji' do
				let(:body) { '🙈🙉🙊' }

				its_result { is_expected.to be true }
			end

			context 'with a text & emoji' do
				let(:body) { 'Hi 🙂' }

				its_result { is_expected.to be false }
			end

			context 'with just a text' do
				let(:body) { 'Hi!' }

				its_result { is_expected.to be false }
			end
		end
	end
end
