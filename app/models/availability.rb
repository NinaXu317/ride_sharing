require 'time'

class Availability < ApplicationRecord
    defaults distance: 0.0, matched_request_id: -1, availability_status: "started", matched_user_id: -1
    has_many :users, :through => :posts
    has_one :request
    scope :unmatched, ->{ where(matched_request_id: -1) }
    scope :started, -> { where(availability_status: "started")}
    geocoded_by :start_street_address, :latitude => :start_lat, :longitude => :start_lon
    geocoded_by :end_street_address, :latitude => :end_lat, :longitude => :end_lon
    before_save :geocode_end


    def self.search (param)
        puts param[:start_street_address]
        puts param[:end_street_address]
        puts param[:trip_time]
        # results = city_matches("start_city", "end_city", param[:start_city].lstrip.downcase, param[:end_city].lstrip.downcase).time_matches(param[:trip_date], param[:trip_time]).price_matches(param[:lowest_acceptable_price]) 
        return nil unless results.length > 0
        return results
    end

    def self.city_matches(start_param, end_param, start_name, end_name)
        where("lower(#{start_param}) LIKE ? AND lower(#{end_param}) LIKE ?", "%#{start_name}", "%#{end_name}")
    end

    # def self.combine_datetime(param_time)
    #     date_time = ("#{param_date}".to_s + " "+ "#{param_time}".to_s).to_datetime
    #     date_time
    # end

    def self.time_matches(param_time)
        date_time = param_time.to_s.to_datetime
        before = date_time - (0.5 / 24.0)
        after = date_time + (0.5 / 24.0)
        where("trip_time BETWEEN ? AND ? ", before, after)
    end

    def self.price_matches(param_price)
        low = param_price.to_i - 5
        high = param_price.to_i + 5
        where("lowest_acceptable_price BETWEEN ? AND ? ", low, high)
    end

    private 
    def geocode_end
        if start_street_address_changed?
            geocoded = Geocoder.search(start_street_address).first
            if geocoded
                self.start_lat = geocoded.latitude
                self.start_lon = geocoded.longitude
            end
        end
        if end_street_address_changed?
            geocoded = Geocoder.search(end_street_address).first
            if geocoded
                self.end_lat = geocoded.latitude
                self.end_lon = geocoded.longitude
            end
        end
    end
end