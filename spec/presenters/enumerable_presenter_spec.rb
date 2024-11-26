require 'rails_helper'

RSpec.describe EnumerablePresenter do
	subject { decorated }

	let(:collection)  { model_class.all }
	let(:decorated)   { collection.decorate! }
	let(:model_class) { DummyModel }

	before { model_class.first_or_create! }

	describe '#dom_class' do
		its_result { is_expected.to eq %w[ dummy_models ] }

		context 'with an empty relation' do
			let(:collection) { model_class.none }

			its_result { is_expected.to be_empty }
		end
	end
end
