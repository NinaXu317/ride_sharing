require 'time'

class Availability < ApplicationRecord
    has_many :users, :through => :posts
    has_one :request
    scope :unmatched, ->{ where(matched_request_id: -1) }

    def self.search (param)
        results = city_matches("start_city", "end_city", param[:start_city].lstrip.downcase, param[:end_city].lstrip.downcase).time_matches(param[:trip_date], param[:trip_time]).price_matches(param[:lowest_acceptable_price]) 
        return nil unless results.length > 0
        return results
    end

    def self.city_matches(start_param, end_param, start_name, end_name)
        where("lower(#{start_param}) LIKE ? AND lower(#{end_param}) LIKE ?", "%#{start_name}", "%#{end_name}")
    end

    def self.combine_datetime(param_date, param_time)
        date_time = ("#{param_date}".to_s + " "+ "#{param_time}".to_s).to_datetime
        date_time
    end

    def self.time_matches(param_date, param_time)
        date_time = combine_datetime(param_date, param_time)
        before = date_time - (0.5 / 24.0)
        after = date_time + (0.5 / 24.0)
        where("trip_time BETWEEN ? AND ? ", before, after)
    end

    def self.price_matches(param_price)
        low = param_price.to_i - 10
        high = param_price.to_i + 10
        where("lowest_acceptable_price BETWEEN ? AND ? ", low, high)
    end
end