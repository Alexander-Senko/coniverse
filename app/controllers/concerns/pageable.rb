require 'memery'

concern :Pageable do
	include Memery

	class Page
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

		def of records
			@records =
					case records
					when Array
						records
					when ActiveRecord::Relation
						records.send looking_forward? ? :first : :last, size
					when Draper::CollectionDecorator
						records.class.decorate of records.object
					else
						raise ArgumentError, "no records for #{records.inspect}"
					end
		end

		delegate :[], :to_query,
				to: :@params

		def size = @params[:size]&.to_i

		def full? = @records.size == size

		def inner? = (looking_forward? or looking_backward?)
		def last?  = (not inner?)

		def looking_backward? = :before.in? @params
		def looking_forward?  = :after .in? @params

		def previous? = (full? and (last? or looking_backward?))
		def next?     = (full? and looking_forward?)

		def previous = turn before: @records.first
		def next     = turn after:  @records.last

		def turn **boundary
			self.class.new(
					**(boundary
							.transform_values { it.created_at.iso8601 9 }
					),

					**settings,
			)
		end

		def settings
			@params.except *%i[
					before after
			]
		end

		def rendering_method = looking_forward? ? :append : :prepend
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
					(Engine if defined? Engine), # this one
					*engines,                    # the ones of a controller
					Rails.application,           # host app
			]
					.compact
					.map { it.root / 'app/views/pageable' }
		end
	end

	protected

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

	private

	def end_of_association_chain
		super
				.tap { break it.where it.arel_table[:created_at].lt page[:before] if page&.looking_backward? }
				.tap { break it.where it.arel_table[:created_at].gt page[:after]  if page&.looking_forward? }
	end
end
