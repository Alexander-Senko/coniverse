RSpec.shared_examples 'identified by UUID' do
	let(:record) { described_class.first_or_create! }

	describe '#to_param' do
		subject { record.to_param }

		it 'is URL-encoded' do
			expect(ERB::Util.url_encode subject)
					.to eq subject
		end

		it 'is shorter than the ID' do
			expect(subject.length)
					.to be < record.id.length
		end
	end

	describe '.find' do
		it 'accepts encoded IDs' do
			expect(described_class.find record.to_param)
					.to eq record
		end

		it 'still accepts original IDs' do
			expect(described_class.find record.id)
					.to eq record
		end

		it 'still accepts hexadecimal strings' do
			expect(described_class.find record.id.remove '-')
					.to eq record
		end
	end
end
