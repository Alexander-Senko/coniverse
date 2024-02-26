require 'support/records'

RSpec.shared_examples 'pageable resource' do
	let(:page_size)         { rand(3) + 1 }
	let(:number_of_records) { page_size * 2 + 1 }
	let(:records)           { Records.new model_class.all, number_of_records }

	path = module_parent.name.demodulize.underscore

	describe "GET /#{path}" do
		subject { response }

		let(:page) { {
				size: page_size,
		} }

		before do
			records.create!

			get "/#{$namespace}/#{path}", params:
		end

		context 'without pagination' do
			let(:params) { {} }

			it { is_expected.to have_http_status :ok }
		end

		context 'with pagination' do
			let(:params) { { page: } }

			it { is_expected.to have_http_status :ok }

			context 'when backward' do
				let(:params) { { page: { **page, before: records.scope.maximum(:created_at) } } }

				it { is_expected.to have_http_status :ok }
			end

			context 'when forward' do
				let(:params) { { page: { **page, after: records.scope.minimum(:created_at) } } }

				it { is_expected.to have_http_status :ok }
			end
		end
	end
end
