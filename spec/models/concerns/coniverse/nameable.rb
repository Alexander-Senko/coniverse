module Coniverse
	RSpec.shared_context 'nameable model' do
		before { I18n.config.enforce_available_locales = false }

		it { is_expected.to be_a Nameable }

		describe '#name' do
			let(:model) { subject.receiver }
			let(:name)  { 'foo' }

			before { model.update name: }

			context 'when localized' do
				its_result { is_expected.to eq name }

				its_result do
					I18n.with_locale :de do
						is_expected.to be_nil
					end
				end
			end

			context 'when international' do
				before { model.name_message.update lang: nil }

				its_result { is_expected.to eq name }

				its_result do
					I18n.with_locale :de do
						is_expected.to eq name
					end
				end

				context 'with a localized one' do
					let(:localized_name) { 'bar' }

					before { model.update name: localized_name }

					its_result { is_expected.to eq localized_name }

					its_result do
						I18n.with_locale :de do
							is_expected.to eq name
						end
					end
				end
			end
		end
	end
end
