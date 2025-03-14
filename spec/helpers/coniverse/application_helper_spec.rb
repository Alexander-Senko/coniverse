# frozen_string_literal: true

require 'rails_helper'

module Coniverse
	RSpec.describe ApplicationHelper do
		subject { helper }

		before do
			helper.instance_variable_set :@title, title if
					defined? title
		end

		describe '#title' do
			its_result { is_expected.to eq Engine.title }

			context 'with a title' do
				let(:title) { SecureRandom.uuid }

				its_result { is_expected.to eq "#{title} — #{Engine.title}" }

				context 'with many' do
					let(:title) { rand(2..4).times.map { SecureRandom.uuid } }

					its_result { is_expected.to eq "#{title * ' — '} — #{Engine.title}" }
				end

				context 'with an Array' do
					let(:title) { size.times.map { SecureRandom.uuid } }

					context 'with none' do
						let(:size) { 0 }

						its_result { is_expected.to eq Engine.title }
					end

					context 'with a single one' do
						let(:size) { 1 }

						its_result { is_expected.to eq "#{title.sole} — #{Engine.title}" }
					end

					context 'with many' do
						let(:size) { rand 2..4 }

						its_result { is_expected.to eq "#{title * ' — '} — #{Engine.title}" }
					end

					context 'with blanks' do
						let(:size)   { rand 1..10 }
						let(:blanks) { [ nil, '', ' ' ] }

						before do
							size.times do # insert a blank
								title[rand(title.size), 0] = blanks.sample
							end
						end

						its_result { is_expected.to eq "#{(title - blanks) * ' — '} — #{Engine.title}" }
					end
				end
			end
		end
	end
end
