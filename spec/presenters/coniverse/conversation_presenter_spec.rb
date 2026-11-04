# frozen_string_literal: true

require 'rails_helper'

require 'presenters/concerns/linkable'

module Coniverse
	RSpec.describe ConversationPresenter do
		let(:attributes)    { { actors: } }
		let(:actors)        { Actor.limit actors_number }
		let(:actors_number) { 0 }

		before do # optimizations
			Actor.create! [] * (actors_number - Actor.count).clamp(0...)

			allow_any_instance_of(Actor).to receive :name, &:id
		end

		describe '.model_class' do
			its_result { is_expected.to eq Conversation }
		end

		shared_context :monologue do
			let(:actors_number) { 1 }
		end

		shared_context :dialogue do
			let(:actors_number) { 2 }
		end

		shared_context :group do
			let(:actors_number) { 3 }
		end

		describe '#dom_class' do
			let(:flags) { decorated.flags }

			its_result { is_expected.to eq flags + %w[ message text html conversation ] }

			it_behaves_like :monologue do
				its_result { is_expected.to include 'monologue' }
			end

			it_behaves_like :dialogue do
				its_result { is_expected.to include 'dialogue' }
			end

			it_behaves_like :group do
				its_result { is_expected.to include 'group' }
			end
		end

		it_behaves_like :linkable do
			describe '#url' do
				its_result { is_expected.to eq "/coniverse/messages/#{record.id}" }
			end
		end

		it_behaves_like(:monologue) { it_behaves_like :linkable } # with a title
	end
end
