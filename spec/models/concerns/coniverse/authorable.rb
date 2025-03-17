# frozen_string_literal: true

module Coniverse
	RSpec.shared_context :authorable do
		let(:actor) { Actor.first_or_create! }

		it { is_expected.to be_an Authorable }

		shared_context 'with current actor' do
			around { Current.set actor:, &it }
		end

		describe 'callbacks' do
			subject { described_class.new }

			shared_context 'authorable' do
				let(:association) { subject.authors }
			end

			shared_context 'editable' do
				let(:association) { subject.editors }
			end

			shared_examples 'assigns an actor' do
				it 'associates the record with current actor' do
					expect { subject.save! }
							.to change { association.reload.to_a }
									.to [ Current.actor ]
				end
			end

			shared_examples 'does nothing' do
				it 'doesn’t update the association' do
					expect { subject.save! }
							.not_to change { association.reload }
				end
			end

			describe 'on create' do
				it_behaves_like 'authorable' do
					include_examples 'does nothing'

					it_behaves_like 'with current actor' do
						include_examples 'assigns an actor'
					end
				end

				it_behaves_like 'editable' do
					include_examples 'does nothing'

					it_behaves_like 'with current actor' do
						include_examples 'does nothing'
					end
				end
			end

			describe 'on update' do
				before { subject.save! } # shouldn’t be new

				it_behaves_like 'authorable' do
					include_examples 'does nothing'

					it_behaves_like 'with current actor' do
						include_examples 'does nothing'
					end
				end

				it_behaves_like 'editable' do
					include_examples 'does nothing'

					it_behaves_like 'with current actor' do
						include_examples 'assigns an actor'
					end
				end
			end
		end
	end
end
