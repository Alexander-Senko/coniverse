# frozen_string_literal: true

# Enhanced nested method chains
#
# rubocop:disable Layout/MultilineMethodCallIndentation

require 'rails_helper'

module Coniverse
	RSpec.describe 'Actors' do
		include Engine.routes.url_helpers

		let(:model_class) { Actor }
		let(:model)       { model_class.first_or_create! }

		describe 'current' do
			let(:url) { current_actor_path model }

			def current_actor
				get '/coniverse/current/actor'

				JSON(response.body)
						&.then { model_class.new it }
			end

			describe 'POST /actors/:id/current' do
				subject { post url }

				it 'sets the actor as current' do
					expect { subject }
							.to change { current_actor }
									.to model
				end
			end

			describe 'DELETE /actors/:id/current' do
				subject { delete url }

				context 'with a current actor' do
					before { post current_actor_path actor }

					context 'with the same one' do
						let(:actor) { model }

						it 'unsets the current actor' do
							expect { subject }
									.to change { current_actor }
											.from(model).to nil
						end
					end

					context 'with another one' do
						let(:actor) { model_class.without(model).first_or_create! }

						it 'keeps the current actor' do
							expect { subject }
									.not_to change { current_actor }
						end
					end
				end
			end
		end
	end
end
