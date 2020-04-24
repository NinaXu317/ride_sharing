Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: 'confirmations'
  }
  resources :makes
  resources :posts
  resources :vehicles
  resources :requests
  resources :availabilities
  resources :users
  root 'static_pages#home'
  get 'about', to: "static_pages#about"
  get 'help', to: "static_pages#help"
  get '/search_rides', to: "availabilities#search"
  post '/request_rides', to: "availabilities#match"
  get 'search_requests', to: "requests#index"
  get '/signup', to: "users#new"
  get "/login", to: "sessions#new"
  post "/sessions", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"
  post "/message", to: "notifications#message"
  get "/notify", to: "notifications#notify"
  get "/pickup", to: "rides#pickup"
end
