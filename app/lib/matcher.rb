require 'date'
require 'time'

class Matcher

    def add_item_to_match id, start_lat, start_lon, end_lat, end_lon, trip_time, acceptable_price
        @availability_id = id
        @start_lat = start_lat
        @start_lon = start_lon
        @end_lat = end_lat
        @end_lon = end_lon
        @trip_time = trip_time
        @acceptable_price = acceptable_price.to_f
    end
    
    def find_all_availabilities unmatched_availabilities
        @all_availabilities = unmatched_availabilities
    end

    def find_best_match
        @all_availabilities.each do |a|
            if city_matches(a) && time_matches(a["trip_time"]) && price_matches(a["lowest_acceptable_price"])
                return a["id"]
            end
        end
        return nil
    end

    def city_matches avail
        if start_address_matches(avail['start_lat'], avail['start_lon']) && end_address_matches(avail['end_lat'], avail['end_lon'])
            return true
        end
        return false
    end

    def start_address_matches start_lat, start_lon
        if Geocoder::Calculations.distance_between([start_lat, start_lon], [@start_lat, @start_lon]) <= 1
            return true
        end
        return false
    end

    def end_address_matches end_lat, end_lon
        if Geocoder::Calculations.distance_between([end_lat, end_lon], [@end_lat, @end_lon]) <= 1
            return true
        end
        return false
    end

    def time_matches(time_param)
        date_time = time_param.to_datetime
        before = date_time - (0.25 / 24.0)
        after = date_time + (0.25 / 24.0)
        if date_time >= before && date_time <= after
            return true
        end
        return false
    end

    def price_matches(availability_price)
        low = availability_price.to_f - 5.0
        high = availability_price.to_f + 5.0
        if @acceptable_price >= low && @acceptable_price <= high
            return true
        end
        return false
    end

end
