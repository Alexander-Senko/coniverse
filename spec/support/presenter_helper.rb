# frozen_string_literal: true

RSpec.shared_context :presenter do
	subject { decorated }

	let(:record)      { model_class.create! attributes.select { model_class.method_defined? "#{it}=" } }
	let(:decorated)   { record.decorate! }
	let(:model_class) { described_class.model_class }
	let(:attributes)  { {} }

	it { is_expected.to be_a described_class }
end

RSpec.configure do |config|
	config.include_context :presenter, type: :presenter
end
