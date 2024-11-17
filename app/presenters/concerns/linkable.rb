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

	def current_page?
		h.current_page? self
	rescue NoMethodError => error
		raise unless error.name.ends_with? '_path'

		false
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
				&.optional { strip_links it unless current_page? }
	end
end
