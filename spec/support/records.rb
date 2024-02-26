class Records < Struct.new :scope, :total
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

	def scoped &scope
		tap do
			self.scope = self.scope
					.instance_eval &scope
		end
	end

	private

	def deficit size = total
		[ 0,
				size - unscope(:offset, :limit).count
		].max
	end
end
