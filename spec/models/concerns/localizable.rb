RSpec.shared_context 'localizable model' do
	lang = :ru

	before { I18n.config.enforce_available_locales = false }

	it { is_expected.to be_a Localizable }

	describe '.for_locale' do
		before do
			[
					I18n.locale,
					lang,
					nil,
			].each { subject[it].create! }
		end

		its_result       { is_expected.to all be_international.or have_attributes lang: I18n.locale }
		its_result(lang) { is_expected.to all be_international.or have_attributes lang: }
		its_result(nil)  { is_expected.to all be_international }
	end

	describe '#for_locale' do
		let(:model) { subject.receiver.tap { it.lang = lang } }

		shared_examples 'returns a corresponding translation' do
			its_result       { is_expected.to have_attributes lang: I18n.locale }
			its_result(lang) { is_expected.to have_attributes lang: }
			its_result(nil)  { is_expected.to be_international }
		end

		context 'with a translation' do
			before do
				model.save! # should be persisted
				model.translations.for_locale.create!
				model.translations.international.create!
				model.translations.for_locale(lang).create! # never used
			end

			its_result(lang) { is_expected.to eq model }

			include_examples 'returns a corresponding translation'
		end

		context 'with an international one' do
			before do
				model.save! # should be persisted
				model.translations.international.create!
			end

			its_result       { is_expected.to be_international }
			its_result(lang) { is_expected.to eq model }
			its_result(nil)  { is_expected.to be_international }
		end

		context 'without translation' do
			its_result       { is_expected.to eq model }
			its_result(lang) { is_expected.to eq model }
			its_result(nil)  { is_expected.to eq model }
		end
	end

	describe '#detect_language!' do
		let(:model) { subject.receiver }
		let(:lang0) { :cn }

		before do
			model.lang = lang0

			if (example = self).respond_to? :text
				model.define_singleton_method(:text) { example.text }
			end
		end

		shared_examples 'detects language' do
			its_result { is_expected.to eq self.lang&.to_s }
		end

		shared_examples 'updates language' do
			before { subject[] }

			it { expect(model).to have_attributes lang: self.lang }
		end

		shared_examples 'keeps language' do
			before { subject[] }

			it { expect(model).to have_attributes lang: lang0 }
		end

		context 'with a default language' do
			let(:text) { 'Hello! This is a sample text in English.' * 10 }
			let(:lang) { I18n.locale }

			include_examples 'detects language'
			include_examples 'updates language'
		end

		context 'with a reliable language' do
			let(:text) { 'Привет! Это пример текста на русском.' * 10 }
			let(:lang) { :ru }

			include_examples 'detects language'
			include_examples 'updates language'
		end

		context 'when uncertain' do
			let(:text) { 'Hello! This is a sample text in English.' }

			its_result { is_expected.to eq lang0 }

			include_examples 'keeps language'
		end

		context 'with no language' do
			let(:text) { 100.times.map { rand 10 ** 10 } } # random numbers
			let(:lang) {}

			include_examples 'detects language'
			include_examples 'updates language'
		end

		context 'with no text' do
			let(:lang) {}

			context 'when empty' do
				let(:text) { '' }

				include_examples 'detects language'
				include_examples 'updates language'
			end

			context 'when none' do
				let(:text) {}

				include_examples 'detects language'
				include_examples 'updates language'
			end

			context 'when the method is missing' do
				include_examples 'detects language'
				include_examples 'updates language'
			end
		end
	end
end
