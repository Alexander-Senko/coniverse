require 'rails_helper'

module Coniverse
	RSpec.describe Message::HTMLPresenter do
		subject { decorated }

		let(:record)      { model_class.create! attributes }
		let(:decorated)   { record.decorate! }
		let(:model_class) { Message::HTML }
		let(:attributes)  { { title: } }
		let(:title)       {}

		shared_context 'with a title' do
			let(:title) { "<code>#{SecureRandom.uuid}</code>" }

			shared_context 'with links' do
				let(:title) { [ link_to('[link]', '/'), super() ] * ' ' }
			end
		end

		it { is_expected.to be_a described_class }

		describe '#dom_class' do
			let(:flags) { decorated.flags }

			its_result { is_expected.to eq %w[ message text html ] + flags }
		end

		describe '#url' do
			its_result { is_expected.to eq "/coniverse/messages/#{record.id}" }
		end

		describe '#link' do
			def current_page?(...) = false

			its_result do
				is_expected.to have_tag('a') do |links|
					link = links.sole

					expect(link['href'])
							.to eq decorated.url
					expect(link.text)
							.to eq url_for(record)
				end
			end

			it_behaves_like 'with a title' do
				its_result do
					is_expected.to have_tag('a') do |links|
						link = links.sole

						expect(link['href'])
								.to eq decorated.url
						expect(link.text)
								.to eq record.title
					end
				end

				it_behaves_like 'with links' do
					its_result do
						is_expected.to have_tag('a') do |links|
							link = links.sole

							expect(link.text)
									.to eq strip_links(record.title)
						end
					end
				end
			end

			context 'on a resource’s page' do
				def current_page?(...) = true

				its_result { is_expected.to be_empty }

				it_behaves_like 'with a title' do
					its_result { is_expected.to eq record.title }

					it_behaves_like 'with links' do
						its_result { is_expected.to eq record.title }
					end
				end
			end
		end
	end
end
