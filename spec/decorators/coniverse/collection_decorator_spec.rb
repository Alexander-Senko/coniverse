require 'rails_helper'

module Coniverse
	RSpec.describe CollectionDecorator do
		subject { decorated }

		let(:collection)  { model_class.all }
		let(:decorated)   { described_class.decorate collection }
		let(:model_class) { DummyModel }

		before { model_class.first_or_create! }

		describe '#dom_class' do
			subject { super().dom_class }

			it { is_expected.to eq %w[ dummy_models ] }

			context 'with an empty relation' do
				let(:collection) { model_class.none }

				it { is_expected.to be_empty }
			end
		end
	end
end
