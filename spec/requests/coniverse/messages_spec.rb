require 'rails_helper'

module Coniverse
	$namespace = Engine.engine_name

	RSpec.describe 'Messages' do
		let(:model_class) { Message }

		let(:posted) { model_class.new body:, lang:, title:, parents: }
		let(:params) { { message: fields.to_h { [it, posted.send(it)] } } }

		let(:title) { 'Message title' }
		let(:body)  { 'Message body' }
		let(:lang)  { I18n.available_locales.sample }

		let(:parent)  { model_class.create }
		let(:parents) { [ *parent, model_class.create ] }

		describe 'create' do
			let(:fields)  { %i[ body lang title ] }
			let(:created) { model_class.find Rails.application.routes.recognize_path(response.headers['Location'])[:id] }

			shared_examples 'creates a message' do
				it 'succeeds' do
					expect(response).to have_http_status :created
				end

				it 'creates a message with provided data' do
					expect(created.attributes.slice(fields)).to eq posted.attributes.slice(fields)
				end
			end

			describe 'POST /messages' do
				let(:fields) { super().including :parent_ids }

				before { post "/#{$namespace}/messages", params: }

				include_examples 'creates a message'

				it 'sets parents' do
					expect(created.parents).to eq parents
				end
			end

			describe 'POST /messages/:id/messages' do
				before { post "/#{$namespace}/messages/#{parent.id}/messages", params: }

				include_examples 'creates a message'

				it 'sets a parent' do
					expect(created.parents).to eq [ parent ]
				end
			end
		end
	end
end
