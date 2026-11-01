# frozen_string_literal: true

# rubocop:disable RSpec/LeakyLocalVariable

RSpec.shared_context :content do
	let(:content_types) { [ *receiver.content_type ] }

	def self.content_types(scope = [ described_class ]) = scope
			.grep(...Content)
			.flat_map(&:content_types)

	descendant_content_types = content_types described_class.descendants
	ancestor_content_types   = content_types(described_class.ancestors)
			.excluding(content_types)

	it { is_expected.to be_a Content }

	describe '.content_types' do
		its_result { is_expected.to eq content_types }
	end

	describe '.with_content_type' do
		descendant_content_types
				.excluding(*content_types)
				.each do |content_type|
					its_result(content_type) { is_expected.to be_in described_class.descendants }
				end

		content_types
				.each do |content_type|
					its_result(content_type) { is_expected.to eq described_class }
				end

		its_result('invalid') { is_expected.to be_nil }
		its_result(nil)       { is_expected.to be_nil }
	end

	describe '#content_type' do
		let(:model) { receiver }

		its_result { is_expected.to eq model.class.content_type }

		context 'when updated' do
			before { model.update content_type: }

			context 'with a valid value' do
				let(:content_type) { content_types.last }

				its_result { is_expected.to eq content_type }

				it { expect(model).to be_valid }
			end

			context 'with an invalid value' do
				let(:content_type) { 'invalid' }

				its_result { is_expected.to eq content_type }

				it { expect(model).not_to be_valid }
			end if described_class.content_types.any?

			context 'with a descendant’s value' do
				let(:content_type) { descendant_content_types.sample }
				let(:reloaded)     { described_class.find model.id }

				its_result { is_expected.to eq content_type }

				it { expect(model).to be_valid }
				it { expect(reloaded).to be_a described_class.with_content_type(content_type) }
			end if descendant_content_types.any?

			context 'with an ancestor’s value' do
				let(:content_type) { ancestor_content_types.sample }

				its_result { is_expected.to eq content_type }

				it { expect(model).not_to be_valid }
			end if ancestor_content_types.any?

			context 'with nil' do
				let(:content_type) {}

				its_result { is_expected.to eq model.class.content_type }
			end
		end
	end
end
