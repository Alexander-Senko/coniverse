# frozen_string_literal: true

# = Content concern
#
# This concern is used to mark a class as content.
#
# == Content type
#
# It provides a default content type and validates that the content
# type is included in the allowed content types for the class.
#
# If a subclass is found with the given content type, it will convert
# the instance to that subclass.
concern :Content do
	prepended do
		# Default content type for this class and its descendants
		class_attribute :content_type,
				instance_accessor: false

		validates :content_type, inclusion: { in: -> { it.class.content_types } },
				if: -> { type == self.class.name }
	end

	class_methods do
		include Memery

		# Allowed content types for this class
		memoize def content_types = [ *content_type ]

		# Looks for a subclass with the given content type.
		# If the content type is found in the current class, it returns self.
		memoize def with_content_type content_type
			return self if
					content_type.in? content_types

			descendants
					.find { it.content_types.include? content_type }
		end
	end

	# Returns the content type, falling back to the class default if not set.
	def content_type = super || self.class.content_type

	# Converts to a subclass with the given content type if any.
	def content_type=(...)
		super

		self.class.with_content_type(content_type)
				&.then { self.type = it }
	end
end
