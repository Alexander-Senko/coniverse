# frozen_string_literal: true

module Coniverse
	RSpec.shared_context :nameable do
		before { I18n.config.enforce_available_locales = false }

		it { is_expected.to be_a Nameable }

		describe '#name' do
			let(:model) { receiver }
			let(:name)  { 'foo' }

			before { model.update name: }

			# rubocop:disable-next Rails/I18nLocaleAssignment
			shared_context 'with a different locale' do
				# HACK: `around { I18n.with_locale :de, &it }` messes with record creation
				before { I18n.locale = :de }
				after  { I18n.locale = :en }
			end

			context 'when localized' do
				its_result { is_expected.to eq name }

				it_behaves_like 'with a different locale' do
					its_result { is_expected.to be_nil }
				end
			end

			context 'when international' do
				before { model.name_message.update lang: nil }

				its_result { is_expected.to eq name }

				it_behaves_like 'with a different locale' do
					its_result { is_expected.to eq name }
				end

				context 'with a localized one' do
					let(:localized_name) { 'bar' }

					before { model.update name: localized_name }

					its_result { is_expected.to eq localized_name }

					it_behaves_like 'with a different locale' do
						its_result { is_expected.to eq name }
					end
				end
			end
		end
	end
end
