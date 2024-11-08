module Coniverse
	concern :DOM do
		class_methods do
			def dom_class
				[
						*(ancestors
								.grep(superclass...ApplicationPresenter)
								.flat_map(&__method__)
						),

						*(model_name
								.unnamespaced
								.underscore
								.split('/')
								.map(&:pluralize)
						),
				].uniq
			end
		end

		def dom_class
			[
					*(self.class
							.dom_class
							.map(&:singularize)
					),
			].uniq
		end

		def dom_id
			case __getobj__.class.columns_hash['id'].type
			when :uuid
				id
			else
				dom_id self
			end
		end

		def tag(*, **options, &block)
			(block&.binding&.receiver || helpers)
					.tag.send(tag_name, *,
							id: dom_id,

							class: [ # add
									*dom_class,
									*options.delete(:class),
							],

							**({ lang: } if
									respond_to? :lang
							),
					**options, &block)
		end

		private

		def tag_name
			self.class
					.base_class
					.name
					.underscore
					.dasherize
					.tr('/', '-')
		end
	end
end
