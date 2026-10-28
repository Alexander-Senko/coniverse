# frozen_string_literal: true

RSpec.shared_context :presenter do
	subject { decorated }

	let(:record)      { model_class.create! attributes.select { model_class.method_defined? "#{it}=" } }
	let(:decorated)   { record.decorate! }
	let(:model_class) { described_class.model_class }
	let(:attributes)  { {} }

	it { is_expected.to be_a described_class }

	shared_context :collection do
		let(:collection)  { model_class.all }
		let(:decorated)   { collection.decorate! }
		let(:model_class) { super() }

		before { model_class.first_or_create! }

		it { expect(described_class).to be < Magic::Presenter::Collection }

		it { is_expected.to be_a described_class }

		context 'when converted to an array' do
			let(:decorated) { super().to_a }

			it { is_expected.to be_a described_class }
		end
	end
end

RSpec.configure do |config|
	config.include_context :presenter, type: :presenter
end
