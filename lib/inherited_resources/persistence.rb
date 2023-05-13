# HACK: fixes some persistence issues of Inherited Resources

InheritedResources::Actions.prepend Module.new {
	# FIX: in Rails, `association.build.save` isn't always the same as `association.create`
	def create(...)
		set_resource_ivar end_of_association_chain.create *resource_params

		super
	end
}
