require 'rails_helper'

module Coniverse
	RSpec.describe Message::HTMLPresenter do
		subject { decorated }

		let(:record)      { model_class.create! attributes }
		let(:decorated)   { record.decorate! }
		let(:model_class) { Message::HTML }
		let(:attributes)  { {} }

		it { is_expected.to be_a described_class }

		describe '#dom_class' do
			let(:flags) { decorated.flags }

			its_result { is_expected.to eq %w[ message text html ] + flags }
		end
	end
end
