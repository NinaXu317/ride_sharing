Rails.application.routes.draw do
  resources :makes
  resources :posts
  resources :vehicles
  resources :requests
  resources :availabilities
  resources :users
  root 'static_pages#home'
  get 'static_pages/about'
  get 'static_pages/help'
  get 'search_rides', to: 'availabilities#index'
  get 'search_requests', to: 'requests#index'
  get 'rides_result', to: 'availabilities#search'
  get '/signup', to: "users#new"
  get "/login", to: "sessions#new"
  post "/sessions", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"
end
