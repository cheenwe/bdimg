Rails.application.routes.draw do

  root "searches#index"
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :photos
  resources :searches do
    member do
        post :photo
        post :download
        post :delete
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
