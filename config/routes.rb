Rails.application.routes.draw do

  mount ActionCable.server => '/cable'
  devise_for :users, controllers: {
    confirmations: 'confirmations',
    registrations: 'registrations',
  }
  resources :users do
    resources :trips do
      collection do
        get "/pickup", to: "trips#pickup"
        get "/start", to: "trips#start_trip"
        get "/rider_pickup", to: "trips#rider_pickup"
        get "/trip_complete", to: "trips#trip_complete"
        get "/finish", to: "trips#finish"
        get "/trips", to: "trips#show_upcoming_trip"
      end
    end
    resources :vehicles
    resources :makes
    resources :requests do
      collection do
        get '/search', to: "requests#search"
        post '/request_rides', to: "requests#match"
      end
    end
    resources :posts
    resources :availabilities do
      collection do
        get '/search', to: "availabilities#search"
        post '/request_rides', to: "availabilities#match"
      end
    end
    resources :notifications do
      collection do
        get '/notify', to: "notifications#notify"
        get '/accept', to: "notifications#accept"
      end
    end

  end
  resources :messages, only: [:new, :create]

  root 'static_pages#home' 
  # get '/about', to: "static_pages#about"
  # get '/help', to: "static_pages#help"
  # get '/fill_info', to: "static_pages#fill_information"
  # get '/signup', to: "users#new"
  # get "/login", to: "sessions#new", :as => :new_session
  post "/message", to: "notifications#message"
  # get "/notify", to: "notifications#notify"
  # get "/index", to: "rides#index"
  get "/chat", to: "landing#chat"
  # get 'landing/index'
  get "/landingindex", to: "landing#index"
end
