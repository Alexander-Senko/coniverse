# frozen_string_literal: true

Records = Struct.new :scope, :total do
	cattr_accessor :attributes, default: {}

	delegate_missing_to :scope

	def create! size_or_attributes = total
		case size_or_attributes
		when Integer
			create! [ attributes ] * deficit(size_or_attributes)
		else
			scope.create! size_or_attributes
		end
	end

	def scoped(...)
		tap do
			self.scope = scope
					.instance_exec(...)
		end
	end

	private

	def deficit size = total
		(size - unscope(:offset, :limit).count)
				.clamp 0, size
	end
end
