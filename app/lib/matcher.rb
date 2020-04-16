require 'date'
require 'time'

class Matcher
    def add_item_to_match id, start_address, end_address, trip_time, acceptable_price
        @availability_id = id
        @start_address = start_address.lstrip.downcase
        @end_address = end_address.lstrip.downcase
        @trip_time = trip_time
        @acceptable_price = acceptable_price.to_f
    end

    def find_all_availabilities unmatched_availabilities
        @all_availabilities = unmatched_availabilities
    end

    def find_best_match
        @all_availabilities.each do |a|
            if city_matches(a["start_city"], a["end_city"]) && time_matches(a["trip_time"]) && price_matches(a["lowest_acceptable_price"])
                return a["id"]
            end
        end
        return nil
    end

    def city_matches(curr_start_city, curr_end_city)
        if ("#{curr_start_city}".lstrip.downcase.eql?"#{@start_city}") && ("#{curr_end_city}".lstrip.downcase == "#{@end_city}")
            return true
        end
        return false
    end

    # def combine_datetime(param_date, param_time)
    #     date_time = ("#{param_date}".to_s + " "+ "#{param_time}".to_s).to_datetime
    #     date_time
    # end

    def time_matches(time_param)
        # date_time = combine_datetime(param_date, param_time)
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
