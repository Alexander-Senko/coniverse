# frozen_string_literal: true

require 'rails_helper'

module Coniverse
	RSpec.describe Conversation do
		subject { described_class.create! title:, actors: }

		cattr_reader(:actors) { 2.times.map { Actor.create! name: "Actor ##{it}" } }
		let(:title)           {}

		describe '.between' do
			its_result(actors)                      { is_expected.to contain_exactly subject.receiver }
			its_result(actors.first)                { is_expected.to contain_exactly subject.receiver }
			its_result(              Actor.create!) { is_expected.to be_empty }
			its_result(actors.first, Actor.create!) { is_expected.to be_empty }
		end

		describe '#title' do
			context 'when set' do
				let(:title) { 'Test Conversation' }

				its_result { is_expected.to eq title }
			end

			its_result { actors.each { is_expected.to include it.name } }

			context 'with a current actor' do
				before { Current.actor = actors.first }

				its_result { is_expected.to eq actors.last.name }
			end
		end
	end
end
