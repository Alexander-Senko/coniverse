require 'inherited_resources/naming'
require 'inherited_resources/persistence'

module Coniverse
	class ApplicationController < InheritedResources::Base
		extend InheritedResources::Decoratable # HACK: let it work with Draper

		respond_to :html, :turbo_stream

		self.responder      = ApplicationResponder
		self.resource_class = nil # don't even try to guess

		before_action :verify_requested_format!
	end
end
