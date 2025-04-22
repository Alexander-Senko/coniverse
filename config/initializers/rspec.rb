# frozen_string_literal: true

if defined? RSpec::Core
	RSpec.configure do |config|
		shared_context 'AR presenter' do
			subject { decorated }

			let(:record)      { model_class.create! attributes.reject { not model_class.method_defined? "#{it}=" } }
			let(:decorated)   { record.decorate! }
			let(:model_class) { described_class.model_class }
			let(:attributes)  { {} }

			it { is_expected.to be_a described_class }
		end

		config.include_context 'AR presenter', type: :presenter
	end
end
