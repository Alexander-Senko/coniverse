module Coniverse
	class ApplicationResponder < ActionController::Responder
		include Responders::FlashResponder
		include Responders::HttpCacheResponder

		# Redirects resources to the collection path (index action) instead
		# of the resource path (show action) for POST/PUT/DELETE requests.
		# include Responders::CollectionResponder

		# Configure default status codes for responding to errors and redirects.
		self.error_status    = :unprocessable_entity
		self.redirect_status = :see_other

		def redirect_status
			{ # overrides
					create: :created,
			}[@controller.action_name.to_sym] or super
		end
	end
end
