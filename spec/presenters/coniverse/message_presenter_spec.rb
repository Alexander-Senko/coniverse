require 'rails_helper'

require 'presenters/concerns/dom'
require 'presenters/concerns/linkable'

module Coniverse
	RSpec.describe MessagePresenter do
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

		it_behaves_like 'DOM builder' do
			describe '#dom_class' do
				let(:flags) { decorated.flags }

				its_result { is_expected.to eq %w[ message ] + flags }
			end

			describe '#dom_id' do
				its_result { is_expected.to eq record.id }
			end
		end

		it_behaves_like 'linkable presenter' do
			describe '#url' do
				its_result { is_expected.to eq "/coniverse/messages/#{record.id}" }
			end
		end
	end
end
