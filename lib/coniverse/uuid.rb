# frozen_string_literal: true

module Coniverse
	module UUID
		extend ActiveSupport::Concern

		NIL = '00000000-0000-0000-0000-000000000000'

		class Current < ActiveSupport::CurrentAttributes
			attribute :namespace

			def available? = namespace.present?
		end

		refine Object do
			def uuid?
				# override when applicable
			end

			def to_uuid
				return self if uuid?
				return nil  unless Current.available?

				Digest::UUID.uuid_v5 Current.namespace, to_s
			end
		end

		refine String do
			def uuid?
				match? /\A(\h{8})-?(\h{4})-?(\h{4})-?(\h{4})-?(\h{4})(\h{8})\z/
			end
		end

		included do
			mattr_reader :uuid, default: Digest::UUID.uuid_v5(NIL, name)

			module_function :within_uuid_namespace
		end

		def within_uuid_namespace
			Current.set namespace: uuid do
				yield
			end
		end
	end
end