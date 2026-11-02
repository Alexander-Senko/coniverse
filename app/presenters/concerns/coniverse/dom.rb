# frozen_string_literal: true

# Multiline list items
#
# rubocop:disable Style/RedundantParentheses

module Coniverse
	# = DOM presenter concern
	#
	# Provides HTML DOM helpers.
	concern :DOM do
		included do
			collection_presenter do
				include DOM::Enumerable
			end
		end

		class_methods do
			include Memery

			memoize def dom_class = Set[
					*(ancestors
							.grep(superclass...ApplicationPresenter)
							.map(&__method__)
							.reduce(&:|)
					),

					*(model_name
							.unnamespaced
							.underscore
							.split('/')
							.map(&:pluralize)
					),
			]
		end

		def dom_class = Set[
				*(self.class
						.dom_class
						.map(&:singularize)
				),
		]

		def dom_id
			case __getobj__.class.columns_hash['id'].type
			when :uuid
				id
			else
				h.dom_id self
			end
		end

		def tag(name = tag_name, **options, &)
			# rubocop:disable-next Layout
			h.tag.public_send(name,
					id: dom_id,

					class: [ # add
							*dom_class,
							*options.delete(:class),
					],

					**({ lang: } if
							respond_to? :lang
					),
			**options, &)
		end

		private

		def tag_name = :article
	end
end
