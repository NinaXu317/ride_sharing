class RidesController < ApplicationController
    # include rides_helper
    # require 'open-uri'

    def start_trip
        respond_to do |format|
            format.js
            format.html
        end
    end

    def index
        # ActionCable.server.broadcast "notifications_channel/#{@rider.id}",
        # request_id: @ride.id,
        # accepted: ApplicationController.render(partial: 'rides/accepted_request',
        #                                        locals: { driver: @driver, ride: @ride }),
        # notice_id: notice.id,
        # notice_content: notice.content,
        # notice: "You have #{@ride.rider.notices.for_request.where(kind: "accepted").size} requests accepted!"
    end
    
    def pickup
        # find the request with the driver_id that has the closest timestamp
        @driver_id = current_user.id
        availability = Availability.upcoming.find_closest_availability(@driver_id)
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
                format.js { render partial: 'rides/startRide', :locals => { :curr_lat => curr_lat, :curr_lon => curr_lon }}
            end
        end
    end
end
