# frozen_string_literal: true

module Coniverse
	# = Conversation
	#
	# A conversation is a collection of messages and participating actors.
	#
	# Actors are those who may write messages in a conversation. They are
	# not necessarily have to. Meanwhile, the readers shouldn't be
	# necessarily registered as actors.
	#
	# Depending on the number of actors, a conversation can present:
	# * a monologue (e.g. a diary, notes, etc.);
	# * a dialogue (e.g. a traditional chat);
	# * a group discussion.
	#
	# As a conversation is a message, the message content is used for
	# conversation’s description.
	class Conversation < Message::HTML
		default_scope { reorder updated_at: :desc }

		scope :between, -> *actors { actors.flatten!
			joins(:actors)
					.where(actors: { id: actors })
					.group(:id).having('COUNT(*) = ?', actors.size) # all of them
		}

		def title
			super or
					actors
							.without(Current.actor)
							.map(&:name)
							.join(', ')
							.presence
		end
	end
end
