Rails.application.routes.draw do
	namespace :api do
		namespace :v1 do
			resources :users			
			resources :blogs do
				resources :articles do
					resources :comments
				end
			end
			resources :articles do
					resources :comments
				end
		end	  	
	end
end
