require 'rails_helper'

module Coniverse
	RSpec.describe Message::HTMLDecorator do
		subject { decorated }

		let(:object)      { model_class.create! attributes }
		let(:decorated)   { object.decorate }
		let(:model_class) { described_class.object_class }
		let(:attributes)  { {} }

		describe '#html_class' do
			subject { super().html_class }

			let(:flags) { decorated.flags }

			it { is_expected.to eq %w[ message text html ] + flags }
		end
	end
end