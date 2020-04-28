class RidesController < ApplicationController
    # include rides_helper
    # require 'open-uri'

    def start_trip
        respond_to do |format|
            format.js
            format.html
        end
    end
    
    def rider_pickup
    end

    def trip_complete
        if params[:rating]
            render 'finish'
        else
            respond_to do |format|
                format.html
            end
        end
    end

    def finish
    end

    def index
        @message = Message.new
    end
    
    def pickup
        # find the request with the driver_id that has the closest timestamp
        @driver_id = current_user.id
        availability = Availability.find_closest_availability(@driver_id)
        dest_lat = availability.end_lat
        dest_lon = availability.end_lon
        @availability_id = availability.id
        @rider_id = availability.matched_user_id
        @request_id = availability.matched_request_id
        if @request_id != -10
            ride_request = Request.find_by(id: @request_id)
        end
        rider = User.find(@rider_id)
        if Ride.find_by(driver: current_user, rider: rider, availability_id: @availability_id).nil?
            Ride.create!(driver: current_user, rider: rider, request_id: @request_id, availability_id: @availability_id)
        end
        puts "successfully created"
        if request.xhr?
            # render data on ajax request 
            curr_lat = params[:curr_lat]
            curr_lon = params[:curr_lon]
            # puts curr_lat
            # puts curr_lon
            respond_to do |format|
                format.js { render partial: 'rides/startRide', :locals => { :curr_lat => curr_lat, :curr_lon => curr_lon, :dest_lat => dest_lat, :dest_lon => dest_lon }}
            end
        end
    end

    private
        def rating_params
            # params.require(:user).permit(:username, :email, :password, :password_confirmation, :is_driver, :avatar)
            params.require(:rating).permit(:r)
        end
end
