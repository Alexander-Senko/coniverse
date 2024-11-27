require 'rails_helper'

require 'presenters/concerns/linkable'

module Coniverse
	RSpec.describe Message::TextPresenter do
		subject { decorated }

		let(:record)      { model_class.create! attributes }
		let(:decorated)   { record.decorate! }
		let(:model_class) { Message::Text }
		let(:attributes)  { {} }

		it { is_expected.to be_a described_class }

		describe '#dom_class' do
			let(:flags) { decorated.flags }

			its_result { is_expected.to eq %w[ message text ] + flags }
		end

		it_behaves_like 'linkable presenter' do
			describe '#url' do
				its_result { is_expected.to eq "/coniverse/messages/#{record.id}" }
			end
		end
	end
end
