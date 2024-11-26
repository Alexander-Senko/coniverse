require 'support/records'

RSpec.shared_context 'pageable controller' do
	let(:model_class)       { described_class.resource_class }
	let(:page_size)         { rand(3) + 1 }
	let(:default_page_size) { page_size * 10 }
	let(:number_of_records) { page_size + 1 }
	let(:page)              { Page.new(size: page_size).tap { it.of records.all } }
	let(:records)           { Records.new model_class.all, number_of_records }

	before do
		records.create!

		get :index, params:
	end

	shared_context 'not paginated' do
		let(:params) { {} }
	end

	shared_context 'paginated' do
		let(:params) { { page: } }
	end

	describe '#page' do
		it_behaves_like 'not paginated' do
			its_result { is_expected.to be_nil }

			it_behaves_like 'paginated by default' do
				its_result { is_expected.to have_attributes size: default_page_size }
			end
		end unless described_class.page

		it_behaves_like 'paginated' do
			its_result { is_expected.to have_attributes size: page_size }
		end
	end

	describe '#collection' do
		it_behaves_like 'not paginated' do
			its_result { is_expected.to eq records.all }
			its_result { is_expected.to be_decorated }
		end

		it_behaves_like 'paginated' do
			its_result { is_expected.to eq records.last(page_size) }
			its_result { is_expected.to be_decorated }

			context 'when looking backward' do
				let(:params) { { page: page.previous } }

				its_result { is_expected.to eq records.last(page_size * 2)[...-page_size] }

				context 'when beyond the limit' do
					let(:records) { ex = self; super().scoped { limit ex.page_size } }

					its_result { is_expected.to be_empty }
				end
			end

			context 'when looking forward' do
				let(:params)  { { page: page.next } }
				let(:records) { super().scoped { reverse_order } }

				its_result { is_expected.to eq records.reverse_order.first(page_size + 1)[1...] }

				context 'when beyond the limit' do
					let(:records) { super().scoped { reverse_order } }

					its_result { is_expected.to be_empty }
				end
			end
		end
	end
end
