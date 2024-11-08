require 'rails_helper'

module Coniverse
	RSpec.describe Message::TextPresenter do
		subject { decorated }

		let(:record)      { model_class.create! attributes }
		let(:decorated)   { record.decorate! }
		let(:model_class) { Message::Text }
		let(:attributes)  { {} }

		it { is_expected.to be_a described_class }

		describe '#dom_class' do
			subject { super().dom_class }

			let(:flags) { decorated.flags }

			it { is_expected.to eq %w[ message text ] + flags }
		end
	end
end
