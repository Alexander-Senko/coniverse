require 'rails_helper'

module Coniverse
	RSpec.describe ApplicationDecorator do
		subject { decorated }

		let(:object)      { model_class.new attributes }
		let(:decorated)   { object.decorate  }
		let(:model_class) { DummyModel }
		let(:attributes)  { {} }

		describe '#dom_class' do
			subject { super().dom_class }

			it { is_expected.to match_array %w[ dummy_model flag1 flag3 ] }
		end

		describe '#flags' do
			subject { super().flags }

			it { is_expected.to match_array %w[ flag1 flag3 ] }
		end
	end
end
