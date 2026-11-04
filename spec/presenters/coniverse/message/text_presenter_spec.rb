# frozen_string_literal: true

require 'rails_helper'

require 'presenters/concerns/linkable'

module Coniverse
	RSpec.describe Message::TextPresenter do
		let(:attributes) { { body: } }
		let(:body)       { 'Message body' }

		describe '.model_class' do
			its_result { is_expected.to eq Message::Text }
		end

		it_behaves_like 'DOM builder' do
			describe '#dom_class' do
				let(:flags) { decorated.flags }

				its_result { is_expected.to eq flags + %w[ message text ] }
			end
		end

		it_behaves_like :linkable do
			describe '#url' do
				its_result { is_expected.to eq "/coniverse/messages/#{record.id}" }
			end
		end
	end
end
