# HACK: fixes some naming issues of Inherited Resources

InheritedResources::ClassMethods.prepend Module.new {
	protected

	# FIX: name collisions in case of a parent is of the same class
	def belongs_to(*names, **options, &)
		super.tap do
			next if :instance_name.in? options # overridden?
			next if (resource_instance_name = resources_configuration[:self][:instance_name]) !=
					controller_name.singularize.to_sym # default?

			names
					.map(&:to_sym)
					.grep(resource_instance_name)
					.each do |name|
						resources_configuration[name][:instance_name] = :parent
					end
		end
	end
}























































































































































































































































































































































InheritedResources::ClassMethods.prepend Module.new {
	protected

	# FIX: inconsistent naming (see `#evaluate_parent`)
	def parent
		if parent_type
			get_parent_ivar resources_configuration[parent_type][:instance_name] or
					association_chain.last
		end
	end
}