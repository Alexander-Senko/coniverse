# HACK: fixes some naming issues of Inherited Resources
#   * name collisions when a parent is of the same class

InheritedResources::ClassMethods.prepend Module.new {
	protected

	def belongs_to(*names, **options, &)
		super.tap do
			next if :instance_name.in? options # overridden?
			next if (resource_instance_name = resources_configuration[:self][:instance_name]) !=
					controller_name.singularize.to_sym # default?

			names
					.map(&:to_sym)
					.grep(resource_instance_name)
					.each do |name|
						resources_configuration[:"parent_#{name}"] = {
								**resources_configuration[name],

								instance_name: :parent,
						}
					end
		end
	end
}

InheritedResources::PolymorphicHelpers.prepend Module.new {
	protected

	def parent_type = :"parent_#{super}"
			.tap { break super unless it.in? resources_configuration }
}
