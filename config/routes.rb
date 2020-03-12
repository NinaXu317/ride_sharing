Rails.application.routes.draw do
  resources :vechiles
  resources :requests
  resources :availabilities
  resources :users
  get 'static_pages/home'
  get 'static_pages/about'
  get 'static_pages/help'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
