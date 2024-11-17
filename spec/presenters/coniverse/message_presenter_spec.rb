require 'rails_helper'

require 'presenters/concerns/dom'
require 'presenters/concerns/linkable'

module Coniverse
	RSpec.describe MessagePresenter do
		subject { decorated }

		let(:record)      { model_class.create! attributes }
		let(:decorated)   { record.decorate! }
		let(:model_class) { Message }
		let(:attributes)  { {} }

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

		it_behaves_like 'linkable presenter' do
			describe '#url' do
				its_result { is_expected.to eq "/coniverse/messages/#{record.id}" }
			end
		end

		it_behaves_like 'DOM builder' do
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
end
