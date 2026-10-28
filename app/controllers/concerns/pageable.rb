# frozen_string_literal: true

require 'delegate'
require 'baby_squeel'

# = Pageable controller concern
#
# Include this concern to add pagination support to a controller.
#
# It is designed to work with collections that may change while
# paginating. Thus, we may not use the `offset` parameter for
# pagination, as it may lead to missing or duplicate records. That's
# why we use the `before` and `after` parameters, which are based on
# the immutable `created_at` timestamp.
#
# It provides a `#page` method that returns a `Page` object, which
# can be used to paginate records.
#
# One can set the default pagination parameters (e.g., size) using
# `.page` class configuration attribute.
concern :Pageable do
	include Memery

	# = Page parameters
	#
	# This class is used to encapsulate the pagination parameters and
	# provide methods to navigate through pages.
	#
	# It expects the following parameters:
	# - `size`:   the number of records per page.
	# - `before`: the timestamp to fetch records before (for backward pagination).
	# - `after`:  the timestamp to fetch records after (for forward pagination).
	class Page < Delegator
		include Magic::Presentable

		# Builds a page from the controller's `page` parameters or a settings hash.
		def initialize params
			@params =
					case params
					when ActionController::Parameters
						params
					when Hash
						ActionController::Parameters.new page: params
					else
						raise ArgumentError, "Unexpected parameters: #{params.inspect}"
					end
					.require(:page)
					.permit *%i[
							size
							before after
					]
		end

		def __getobj__ = @records

		# Applies pagination boundaries and size to a relation or enumerable.
		def of records
			@records = records
					.then_try { it.where.has { it.created_at < @params[:before] } if looking_backward? }
					.then_try { it.where.has { it.created_at > @params[:after]  } if looking_forward?  }
					.send looking_forward? ? :first : :last, size
		end

		delegate :to_query,
				to: :@params

		# The configured number of records per page.
		def size = @params[:size]&.to_i

		def full? = @records.size == size

		# Whether this page is an interior one.
		def inner? = (looking_forward? or looking_backward?)
		# Whether this page is at the end of the collection.
		def last?  = (not inner?)

		# Whether the current pagination goes backward.
		def looking_backward? = :before.in? @params
		# Whether the current pagination goes forward.
		def looking_forward?  = :after .in? @params

		# Previous page parameters.
		def previous = turn before: @records.first
		# Next page parameters.
		def next     = turn after:  @records.last

		# A page to turn to.
		def turn **boundary
			self.class.new({
					**(boundary
							.transform_values { it.created_at.iso8601 9 }
					),

					**settings,
			})
		end

		# Shared settings preserved across pagination turns.
		def settings
			@params.except *%i[
					before after
			]
		end
	end

	prepended do
		include ActiveSupport::Configurable

		config_accessor :page, default: ActiveSupport::OrderedOptions.new,
				instance_accessor: false

		pageable_view_paths
				.each { prepend_view_path it }

		helper_method :page
	end

	class_methods do
		using Module.new {
			refine Module do
				def engines
					return if module_parent == self

					[
							"#{self}::Engine".safe_constantize,
							*module_parent.engines,
					].compact
				end
			end
		}

		private

		def pageable_view_paths
			[ # ones of a lower priority go first
					*(Engine if defined? Engine), # this one
					*engines,                     # the ones of a controller
					Rails.application,            # host app
			].map { it.root/'app/views/pageable' }
		end
	end

	protected

	# Current page
	memoize def page
		if :page.in? params
			Page.new params
		elsif (defaults = config.page).any?
			Page.new defaults
		end
	end

	memoize def collection
		return super unless page

		page.of super
	end, condition: -> { page }
end
