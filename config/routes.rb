# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create index]
      resources :blogs do
        resources :articles, only: %i[create index]
      end
      resources :articles, except: %i[create index new] do
        resources :comments, shallow: true
      end
    end
  end
end
