require 'rails_helper'

require 'presenters/concerns/linkable'

module Coniverse
	RSpec.describe Message::TextPresenter do
		it_behaves_like 'DOM builder' do
			describe '#dom_class' do
				let(:flags) { decorated.flags }

				its_result { is_expected.to eq %w[ message text ] + flags }
			end
		end

		it_behaves_like 'linkable presenter' do
			describe '#url' do
				its_result { is_expected.to eq "/coniverse/messages/#{record.id}" }
			end
		end
	end
end
