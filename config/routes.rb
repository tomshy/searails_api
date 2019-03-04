Rails.application.routes.draw do
	namespace :api do
		namespace :v1 do						
				resources :users, only: [:create, :index]
				resources :blogs do
					resources :articles, only: [:create, :index]
				end
				resources :articles, except: [:create, :index, :new] do
					resources :comments, shallow: true
				end			
		end	  	
	end
end
