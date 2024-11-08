require 'rails_helper'

module Coniverse
	RSpec.describe MessagePresenter do
		subject { decorated }

		let(:record)      { model_class.create! attributes }
		let(:decorated)   { record.decorate! }
		let(:model_class) { Message }
		let(:attributes)  { { lang: } }
		let(:lang)        { 'xx' }

		it { is_expected.to be_a described_class }

		describe '#dom_class' do
			subject { super().dom_class }

			let(:flags) { decorated.flags }

			it { is_expected.to eq %w[ message ] + flags }
		end

		describe '#dom_id' do
			subject { super().dom_id }

			it { is_expected.to eq record.id }
		end

		describe '#flat?' do
			subject { super().flat? }

			let(:attributes)           { { **super(), messages: } }
			let(:messageless_messages) { [ Message.new ] * (rand(2) + 1) }

			context 'without child messages' do
				let(:messages) { [] }

				it { is_expected.not_to be true }
			end

			context 'with a single child message' do
				let(:messages) { [ Message.new(messages: messageless_messages) ] }

				it { is_expected.to be true }
			end

			context 'with messageless child messages only' do
				let(:messages) { messageless_messages }

				it { is_expected.to be true }
			end

			context 'with several messages including ones with child messages' do
				let(:messages) { [ Message.new(messages: messageless_messages), *messageless_messages ] }

				it { is_expected.not_to be true }
			end
		end

		describe '#tree?' do
			subject { super().tree? }

			let(:attributes)           { { **super(), messages: } }
			let(:messageless_messages) { [ Message.new ] * (rand(2) + 1) }

			context 'without child messages' do
				let(:messages) { [] }

				it { is_expected.not_to be true }
			end

			context 'with a single child message' do
				let(:messages) { [ Message.new(messages: messageless_messages) ] }

				it { is_expected.not_to be true }
			end

			context 'with messageless child messages only' do
				let(:messages) { messageless_messages }

				it { is_expected.not_to be true }
			end

			context 'with several messages including ones with child messages' do
				let(:messages) { [ Message.new(messages: messageless_messages), *messageless_messages ] }

				it { is_expected.to be true }
			end
		end

		describe '#tag' do
			subject { super().tag(**options) { concat content } }

			let(:options) { {} }
			let(:content) { '[content]' }

			it 'renders an article tag with attributes' do
				is_expected.to have_tag("article##{record.id}") do |articles|
					article = articles.sole

					expect(article['lang'])
							.to eq lang
					expect(article['class'].split)
							.to match_array decorated.dom_class
					expect(article.text)
							.to eq content
				end
			end

			context 'with a class' do
				let(:options) { { class: %w[ c1 c2 ] } }

				it 'renders the tag with extra classes' do
					is_expected.to have_tag("article##{record.id}") do |articles|
						article = articles.sole

						expect(article['lang'])
								.to eq lang
						expect(article['class'].split)
								.to match_array decorated.dom_class + options[:class]
						expect(article.text)
								.to eq content
					end
				end
			end
		end
	end
end
