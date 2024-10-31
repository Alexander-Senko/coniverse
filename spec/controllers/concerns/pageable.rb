# frozen_string_literal: true

require 'support/records'

RSpec.shared_context :pageable do
	let(:model_class)       { described_class.resource_class }
	let(:page_size)         { rand 1..3 }
	let(:number_of_records) { page_size + 1 }
	let(:page)              { Page.new(size: page_size).tap { it.of records.all } }
	let(:records)           { Records.new model_class.all, number_of_records }

	before do
		records.create!

		get :index, params:
	end

	shared_context 'not paginated' do
		let(:params) { {} }

		if (defaults = described_class.page)
			let(:page_size) { defaults[:size] }
		end
	end

	shared_context 'paginated' do
		let(:params) { { page: } }
	end

	describe '#page' do
		subject { controller.send :page }

		it_behaves_like 'not paginated' do
			if (defaults = described_class.page)
				it { is_expected.to be_a Page }

				it 'returns default page settings' do
					expect(subject.size).to eq page_size
				end
			else
				it { is_expected.to be_nil }
			end
		end

		it_behaves_like 'paginated' do
			it { is_expected.to be_a Page }

			it 'returns requested page settings' do
				expect(subject.size).to eq page_size
			end
		end
	end

	describe '#collection' do
		subject { controller.send :collection }

		it_behaves_like 'not paginated' do
			if (defaults = described_class.page)
				it 'returns a page of records' do
					is_expected.to eq records
							.last(page_size)
				end
			else
				it 'returns all the records' do
					is_expected.to eq records
							.all
				end
			end

			it { is_expected.to be_decorated }
		end

		it_behaves_like 'paginated' do
			it 'returns a page of records' do
				is_expected.to eq records
						.last(page_size)
			end

			it { is_expected.to be_decorated }

			context 'when looking backward' do
				let(:params) { { page: page.previous } }

				it 'returns a page of records' do
					is_expected.to eq records
							.last(page_size * 2)[...-page_size]
				end

				context 'when beyond the limit' do
					let(:records) { super().scoped(page_size) { limit it } }

					it { is_expected.to be_empty }
				end
			end

			context 'when looking forward' do
				let(:params)  { { page: page.next } }
				let(:records) { super().scoped { reverse_order } }

				it 'returns a page of records' do
					is_expected.to eq records
							.reverse_order
							.first(page_size + 1)[1...]
				end

				context 'when beyond the limit' do
					let(:records) { super().scoped { reverse_order } }

					it { is_expected.to be_empty }
				end
			end
		end
	end
end
