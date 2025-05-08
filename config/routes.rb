Coniverse::Engine.routes.draw do
	resources :messages do
		resources :messages
	end

	resources :actors do
		member do
			post   'current' =>   :set_current
			delete 'current' => :unset_current
		end
	end
end
