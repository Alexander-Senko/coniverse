require 'rails_helper'

require 'presenters/concerns/dom'

module Coniverse
	RSpec.describe ActorPresenter do
		it_behaves_like 'DOM builder' do
			describe '#dom_class' do
				let(:flags) { decorated.flags }

				its_result { is_expected.to eq %w[ actor ] + flags }
			end

			describe '#dom_id' do
				its_result { is_expected.to eq record.id }
			end
		end
	end
end
