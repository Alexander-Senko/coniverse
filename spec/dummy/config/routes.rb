Rails.application.routes.draw do
	mount Coniverse::Engine => "/coniverse"

	namespace :coniverse do
    resource :current do
			get :actor
		end
	end
end
