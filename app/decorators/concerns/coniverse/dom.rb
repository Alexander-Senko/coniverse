module Coniverse
	concern :DOM do
		class_methods do
			def dom_class
				[
						*(ancestors
								.grep(superclass...ApplicationDecorator)
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
					*(object.class
							.decorator_class
							.dom_class
							.map(&:singularize)
					),
			].uniq
		end

		def dom_id
			case object.class.columns_hash['id'].type
			when :uuid
				id
			else
				h.dom_id object
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

		def tag_name = :article
	end
end
