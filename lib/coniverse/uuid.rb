# frozen_string_literal: true

module Coniverse
	# = UUID
	#
	# Provides deterministic UUID conversion scoped to the including class.
	# Include this module and call `within_uuid_namespace` while creating
	# IDs to make non-UUID identifiers stable UUIDs.
	module UUID
		extend ActiveSupport::Concern

		# Tracks the UUID settings for the current execution context.
		class Current < ActiveSupport::CurrentAttributes
			attribute :namespace

			def available? = namespace.present?
		end

		refine Object do
			def uuid?
				# override when applicable
			end

			# Converts this object to a deterministic UUID in the active namespace.
			# Returns `nil` when no namespace is active.
			def to_uuid
				return self if uuid?
				return unless Current.available?

				Digest::UUID.uuid_v5 Current.namespace, to_s
			end
		end

		refine String do
			def uuid?
				match? /\A(\h{8})-?(\h{4})-?(\h{4})-?(\h{4})-?(\h{4})(\h{8})\z/
			end
		end

		included do
			mattr_reader :uuid,
					default: Digest::UUID.uuid_v5(Digest::UUID.nil_uuid, name)

			module_function :within_uuid_namespace
		end

		# Runs the block with this module's UUID as the current namespace.
		def within_uuid_namespace
			Current.set namespace: uuid do
				yield
			end
		end
	end
end
