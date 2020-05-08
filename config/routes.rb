Rails.application.routes.draw do

  mount ActionCable.server => '/cable'
  devise_for :users, controllers: {
    confirmations: 'confirmations',
    registrations: 'registrations',
  }
  resources :users do
    resources :trips
    resources :vehicles
    resources :makes
    resources :requests do
      collection do
        get 'search', to: "requests#search"
      end
    end
    resources :posts
    resources :availabilities do
      collection do
        get '/search_rides', to: "availabilities#search"
        post '/request_rides', to: "availabilities#match"
        get "/trips", to: "availabilities#show_upcoming_trip"
      end
    end
  end
  resources :messages, only: [:new, :create]
  root 'static_pages#home'
  get '/about', to: "static_pages#about"
  get '/help', to: "static_pages#help"
  get '/fill_info', to: "static_pages#fill_information"
  get '/signup', to: "users#new"
  get "/login", to: "sessions#new", :as => :new_session
  post "/message", to: "notifications#message"
  get "/notify", to: "notifications#notify"
  get "/pickup", to: "rides#pickup"
  # get "/index", to: "rides#index"
  get "/start", to: "rides#start_trip" 
  get "/rider_pickup", to: "rides#rider_pickup"
  get "/trip_complete", to: "rides#trip_complete"
  get "/finish", to: "rides#finish"
  get "/chat", to: "landing#chat"
  # get 'landing/index'
  get "/landingindex", to: "landing#index"
  get "/rides/:id", to: "rides#show"
end
