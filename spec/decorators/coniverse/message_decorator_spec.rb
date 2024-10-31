require 'rails_helper'

module Coniverse
	RSpec.describe MessageDecorator do
		subject { decorated }

		let(:object)      { model_class.create! attributes }
		let(:decorated)   { object.decorate }
		let(:model_class) { described_class.object_class }
		let(:attributes)  { { lang: } }
		let(:lang)        { 'xx' }

		describe '#dom_class' do
			subject { super().dom_class }

			let(:flags) { decorated.flags }

			it { is_expected.to eq %w[ message ] + flags }
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
			include ActionView::Helpers

			subject { super().tag(**options) { content } }

			let(:options) { {} }
			let(:content) { '[content]' }

			it 'renders an article tag with attributes' do
				is_expected.to have_tag("article##{object.id}") do |articles|
					article = articles.sole

					expect(article['lang'])
							.to eq lang
					expect(article['class'].split)
							.to match_array decorated.dom_class
				end

				is_expected.to have_text content
			end

			context 'with a class' do
				let(:options) { { class: %w[ c1 c2 ] } }

				it 'renders the tag with extra classes' do
					is_expected.to have_tag("article##{object.id}") do |articles|
						article = articles.sole

						expect(article['lang'])
								.to eq lang
						expect(article['class'].split)
								.to match_array decorated.dom_class + options[:class]
					end

					is_expected.to have_text content
				end
			end
		end
	end
end
