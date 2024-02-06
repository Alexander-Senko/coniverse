require 'rails_helper'

module Coniverse
	RSpec.describe MessagesDecorator do
		subject { decorated }

		let(:collection)  { model_class.all }
		let(:decorated)   { collection.decorate }
		let(:model_class) { "#{described_class.name.remove(/Decorator$/).singularize}Decorator".constantize }

		before { model_class.first_or_create! }

		describe '#html_class' do
			subject { super().html_class }

			it { is_expected.to eq %w[ messages ] }

			context 'with an empty relation' do
				let(:collection) { model_class.none }

				it { is_expected.to be_empty }
			end
		end
	end
end
