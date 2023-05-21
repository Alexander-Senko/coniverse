Coniverse::Engine.routes.draw do
	resources :messages do
		resources :messages
	end
end
