module Coniverse
	concern :Linkable do
		def url
			__getobj__.try __method__ or
					url_for self
		end

		def link(**, &)
			link_to_unless_current(link_text, url,
					**({ lang: } if
							respond_to? :lang
					),
			**, &)
		end

		private

		def link_text
			%i[
				title
				guess_title
			]
					.lazy
					.filter_map { try it }
					.first
					.then { strip_links it }
		end
	end
end
