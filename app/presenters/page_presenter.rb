# frozen_string_literal: true

class PagePresenter < Magic::Presenter::Base
	def previous_tag(&) = load_page_tag(:previous, &)
	def next_tag(&)     = load_page_tag(:next, &)

	def turbo_stream(&)
		if looking_forward?
			h.concat h.turbo_stream.remove %i[ load_page next ]
			h.concat h.turbo_stream.append(h.resource_collection_name, &)
		else
			h.concat h.turbo_stream.remove %i[ load_page previous ]
			h.concat h.turbo_stream.prepend(h.resource_collection_name, &)
		end
	end

	private

	def previous? = (full? and (last? or looking_backward?))
	def next?     = (full? and looking_forward?)

	def load_page_tag(direction, &)
		raise ArgumentError, "wrong page (given #{direction.inspect}, expected :previous or :next)" unless
				direction.in? %i[ previous next ]

		return unless send "#{direction}?"

		turbo_frame_tag([ :load_page, direction ],
				src: {
						page:   send(direction),
						format: :turbo_stream,
				},

				loading: :lazy,
		&)
	end
end
