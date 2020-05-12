Rails.application.routes.draw do

  mount ActionCable.server => '/websocket'
  devise_for :users, controllers: {
    confirmations: 'confirmations',
    registrations: 'registrations',
  }
  resources :users do

    get "/rider_start_trip", to: "rider#start_trip"
    get "/rider_during_trip", to: "rider#during_trip"
    get "/rider_end_trip", to: "rider#end_trip"

    resources :trips do
      collection do
        get "/start", to: "trips#start_trip"
        get "/rider_pickup", to: "trips#rider_pickup"
        get "/all_trips", to: "trips#show_upcoming_trip"
      end

      member do
        get "/pickup", to: "trips#pickup"
        get "/trip_complete", to: "trips#trip_complete"
        get "/finish", to: "trips#finish"
        get "/trip_complete", to: "trips#trip_complete"
        post "/cancel", to: "trips#cancel"
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
        get '/notify_rider', to: "notifications#notify_rider"
        get '/call_driver', to: "notifications#call_driver"
        get '/notify_cancel', to: "notifications#notify_trip_cancel"
      end
    end
    
  end
  resources :messages, only: [:new, :create]
  get "/landingindex", to: "landing#index"

  root 'static_pages#home'
  post "/message", to: "notifications#message"

end
