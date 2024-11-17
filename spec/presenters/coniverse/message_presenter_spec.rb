require 'rails_helper'

module Coniverse
	RSpec.describe MessagePresenter do
		subject { decorated }

		let(:record)      { model_class.create! attributes }
		let(:decorated)   { record.decorate! }
		let(:model_class) { Message }
		let(:attributes)  { { lang:, title: } }
		let(:lang)        { 'xx' }
		let(:title)       {}
		let(:content)     { '[content]' }
		let(:classes)     { %w[ c1 c2 ] }

		shared_context 'with a title' do
			let(:title) { SecureRandom.uuid }

			shared_context 'with links' do
				let(:title) { [ link_to('[link]', '/'), super() ] * ' ' }
			end
		end

		it { is_expected.to be_a described_class }

		describe '#dom_class' do
			let(:flags) { decorated.flags }

			its_result { is_expected.to eq %w[ message ] + flags }
		end

		describe '#dom_id' do
			its_result { is_expected.to eq record.id }
		end

		describe '#flat?' do
			let(:attributes)           { { **super(), messages: } }
			let(:messageless_messages) { [ Message.new ] * (rand(2) + 1) }

			context 'without child messages' do
				let(:messages) { [] }

				its_result { is_expected.to be_nil }
			end

			context 'with a single child message' do
				let(:messages) { [ Message.new(messages: messageless_messages) ] }

				its_result { is_expected.to be true }
			end

			context 'with messageless child messages only' do
				let(:messages) { messageless_messages }

				its_result { is_expected.to be true }
			end

			context 'with several messages including ones with child messages' do
				let(:messages) { [ Message.new(messages: messageless_messages), *messageless_messages ] }

				it { is_expected.not_to be true }
			end
		end

		describe '#tree?' do
			let(:attributes)           { { **super(), messages: } }
			let(:messageless_messages) { [ Message.new ] * (rand(2) + 1) }

			context 'without child messages' do
				let(:messages) { [] }

				its_result { is_expected.to be_nil }
			end

			context 'with a single child message' do
				let(:messages) { [ Message.new(messages: messageless_messages) ] }

				its_result { is_expected.to be false }
			end

			context 'with messageless child messages only' do
				let(:messages) { messageless_messages }

				its_result { is_expected.to be false }
			end

			context 'with several messages including ones with child messages' do
				let(:messages) { [ Message.new(messages: messageless_messages), *messageless_messages ] }

				its_result { is_expected.to be true }
			end
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
					expect(link['lang'])
							.to eq lang
					expect(link['class'])
							.to be_blank
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
						expect(link['lang'])
								.to eq lang
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
									.to eq url_for(record)
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
									.to eq url_for(record)
						end
			end

			context 'on a resource’s page' do
				def current_page?(...) = true

				its_result { is_expected.to be_empty }

				it_behaves_like 'with a title' do
					its_result { is_expected.to eq record.title }

					it_behaves_like 'with links' do
						its_result { is_expected.to eq strip_links(record.title) }
					end
				end

				it 'renders nothing with extra classes' do
					expect(subject.call class: classes)
							.to be_empty
				end

				it 'renders content specified' do
					expect(subject.call { concat content })
							.to eq content
				end
			end
		end

		describe '#tag' do
			it 'renders an article tag with default attributes' do
				expect(subject.call { concat content })
						.to have_tag("article##{record.id}") do |articles|
							article = articles.sole

							expect(article['lang'])
									.to eq lang
							expect(article['class'].split)
									.to match_array decorated.dom_class
							expect(article.text)
									.to eq content
						end
			end

			it 'renders an article tag with extra classes' do
				expect(subject.call(class: classes) { concat content })
						.to have_tag("article##{record.id}") do |articles|
							article = articles.sole

							expect(article['lang'])
									.to eq lang
							expect(article['class'].split)
									.to match_array decorated.dom_class + classes
							expect(article.text)
									.to eq content
						end
			end
		end
	end
end
