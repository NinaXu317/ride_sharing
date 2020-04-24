require 'open-uri'
require 'json'

module RidesHelper
    def direction_pick_up 
        driver_start_lat = 42.3677767
        driver_start_lon = -71.2577821
        rider_start_lat = 42.3689098
        rider_start_lon = -71.2480046
        # rider_end_lon = 
        # rider_end_lon = 
        place_url = "https://maps.googleapis.com/maps/api/directions/json?"+
        "origin=#{start_lat},#{start_lng}&destination=#{dd_lat},#{dd_lng}&key="+Rails.credentials.google[:maps_api_key]
        url = URI.parse(place_url)
        response = open(url).read
        if result["routes"].empty?
            return nil
        end
        duration = result["routes"].first["legs"].inject(0) {|sum, leg| sum+leg["duration"]["value"]}

        # Return the response as a json if the duration increase is equal to or less than 330 seconds
        duration>org_duration+600 ? nil : response
    end

end
