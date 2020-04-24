class RidesController < ApplicationController
    # include rides_helper
    # require 'open-uri'

    def pickup
        # find the request with the driver_id that has the closest timestamp
        # driver_id = curr_user.id
        # availability_id = Availability.upcoming.posts.find_by(user_id: driver_id)
        # availability = Availability.upcoming.find_by(id: availability_id)
        # rider_id = availability.matched_user_id
        # request_id = availability.matched_request_id
        # if request_id != -10
        #     request = Request.upcoming.find_by(id: request_id)
        # end

        if request.xhr?
            # render data on ajax request 
            curr_lat = params[:curr_lat]
            curr_lon = params[:curr_lon]
            puts curr_lat
            puts curr_lon
            respond_to do |format|
                format.js { render partial: 'rides/startRide', :locals => { :curr_lat => curr_lat, :curr_lon => curr_lon }}
            end
        else
            respond_to do |format|
                format.html
                format.json
            end
        end
    end
end
