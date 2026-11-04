# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EnumerablePresenter do
	let(:collection)  { model_class.all.to_a }
	let(:decorated)   { collection.decorate! }
	let(:model_class) { DummyModel }

	before { model_class.first_or_create! }

	describe '.model_class' do
		its_result { is_expected.to be_nil }
	end

	describe '#dom_class' do
		its_result { is_expected.to match_array %w[ dummy_models ] }

		context 'with an empty relation' do
			let(:collection) { [] }

			its_result { is_expected.to be_empty }
		end
	end
end
