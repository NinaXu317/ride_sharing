Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    confirmations: 'confirmations',
    # registrations: 'registrations'
  }
  
  resources :makes
  resources :posts
  resources :vehicles
  resources :requests
  resources :availabilities
  resources :users
  resources :messages, only:[:new, :create]
  root 'static_pages#home'
  get '/about', to: "static_pages#about"
  get '/help', to: "static_pages#help"
  get '/fill_info', to: "static_pages#fill_information"
  get '/search_rides', to: "availabilities#search"
  post '/request_rides', to: "availabilities#match"
  get 'search_requests', to: "requests#search"
  get '/signup', to: "users#new"
  get "/login", to: "sessions#new", :as => :new_session
  post "/sessions", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"
  post "/message", to: "notifications#message"
  get "/notify", to: "notifications#notify"
  get "/pickup", to: "rides#pickup"
  get "/index", to: "rides#index"
  get "/start", to: "rides#start_trip"
  get "/chat", to: "static_pages#chat"
  # get 'landing/index'
  get "landingIndex", to: "landing#index"

end
