require 'rails_helper'

module Coniverse
	RSpec.describe ApplicationPresenter do
		subject { decorated }

		let(:record)      { model_class.new attributes }
		let(:decorated)   { record.decorate!  }
		let(:model_class) { DummyModel }
		let(:attributes)  { {} }

		it { is_expected.to be_a described_class }

		describe '#dom_class' do
			its_result { is_expected.to match_array %w[ dummy_model flag1 flag3 ] }
		end

		describe '#flags' do
			its_result { is_expected.to match_array %w[ flag1 flag3 ] }
		end
	end
end
