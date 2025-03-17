# frozen_string_literal: true

module Coniverse # :nodoc:
	concern :Authorable do
		included do
			after_create(if: :actor) { authored_by! actor } if method_defined? :authored_by!
			after_update(if: :actor) { edited_by!   actor } if method_defined? :edited_by!
		end

		def actor = Current.actor
	end
end
