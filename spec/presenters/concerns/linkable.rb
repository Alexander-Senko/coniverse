require_relative 'dom'

RSpec.shared_context 'linkable presenter' do
	subject { decorated }

	let(:attributes)  { { **super(), title: } }
	let(:title)       {}

	it { is_expected.to be_a Linkable }

	shared_context 'with a title' do
		let(:title) { SecureRandom.uuid }
	end

	def current_page?(...) = false

	shared_context 'on a resource’s page' do
		def current_page?(...) = true
	end

	it_behaves_like 'DOM builder' do
		describe '#link' do
			its_result do
				is_expected.to have_tag('a') do |links|
					link = links.sole

					expect(link['href'])
							.to eq decorated.url
					expect(link['lang'])
							.to eq lang
					expect(link['class'])
							.to be_blank
					expect(link.text)
							.to eq record.title || url_for(record)
				end
			end

			it_behaves_like 'with a title' do
				its_result do
					is_expected.to have_tag('a') do |links|
						link = links.sole

						expect(link['href'])
								.to eq decorated.url
						expect(link['lang'])
								.to eq lang
						expect(link.text)
								.to eq record.title
					end
				end
			end

			it 'renders the tag with extra classes' do
				expect(subject.call class: classes)
						.to have_tag('a') do |links|
					link = links.sole

					expect(link['href'])
							.to eq decorated.url
					expect(link['lang'])
							.to eq lang
					expect(link['class'].split)
							.to match_array classes
					expect(link.text)
							.to eq record.title || url_for(record)
				end
			end

			it 'renders the tag with content specified' do
				expect(subject.call { concat content })
						.to have_tag('a') do |links|
					link = links.sole

					expect(link['href'])
							.to eq decorated.url
					expect(link['lang'])
							.to eq lang
					expect(link.text)
							.to eq record.title || url_for(record)
				end
			end

			it_behaves_like 'on a resource’s page' do
				its_result { is_expected.to eq record.title.to_s }

				it_behaves_like 'with a title' do
					its_result { is_expected.to eq record.title }
				end

				it 'renders nothing with extra classes' do
					expect(subject.call class: classes)
							.to eq record.title.to_s
				end

				it 'renders content specified' do
					expect(subject.call { concat content })
							.to eq content
				end
			end
		end
	end
end
