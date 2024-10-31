require 'rails_helper'

module Coniverse
	RSpec.describe Message::TextDecorator do
		subject { decorated }

		let(:object)      { model_class.create! attributes }
		let(:decorated)   { object.decorate }
		let(:model_class) { described_class.object_class }
		let(:attributes)  { {} }

		describe '#dom_class' do
			subject { super().dom_class }

			let(:flags) { decorated.flags }

			it { is_expected.to eq %w[ message text ] + flags }
		end
	end
end
