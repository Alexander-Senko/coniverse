# frozen_string_literal: true

require 'rails_helper'

module Coniverse
	RSpec.describe ApplicationPresenter do
		let(:model_class) { DummyModel }

		describe '#dom_class' do
			its_result { is_expected.to match_array %w[ dummy_model flag1 flag3 ] }
		end

		describe '#flags' do
			its_result { is_expected.to match_array %w[ flag1 flag3 ] }
		end

		describe described_class::Collection do
			it_behaves_like :collection do
				describe '#dom_class' do
					its_result { is_expected.to match_array %w[ dummy_models ] }

					context 'with an empty relation' do
						let(:collection) { model_class.none }

						its_result { is_expected.to match_array %w[ dummy_models ] }
					end
				end
			end
		end
	end
end
