require 'time'

class Availability < ApplicationRecord
    defaults trip_distance: 0.0, matched_request_id: -1, availability_status: "started", matched_user_id: -1
    has_one :user, :through => :posts
    has_one :request
    has_many :posts, dependent: :destroy
    scope :unmatched, -> { where(matched_request_id: -1) }
    scope :started, -> { where(availability_status: "started")}
    scope :waiting, -> { where(availability_status: "waiting")}
    scope :upcoming, -> { where(availability_status: "confirmed")}
    scope :completed, -> { where(availability_status: "completed")}
    scope :canceled, -> { where(availability_status: "conceled")}
    geocoded_by :start_street_address, :latitude => :start_lat, :longitude => :start_lon
    geocoded_by :end_street_address, :latitude => :end_lat, :longitude => :end_lon
    before_save :geocode_end
    before_save :geocode_distance
    after_validation :geocode

    def self.post_id user_id
        post_id = Post.where("user_id = ?", user_id)
    end

    def self.search (param)
        puts "I'm in Availability model"
        @start_addr = param[:start_street_address]
        @end_addr = param[:end_street_address]
        results = start_address_matches.time_matches(param[:trip_time]).price_matches(param[:lowest_acceptable_price])
        # results = results.end_address_matches
        # .time_matches(param[:trip_time]).price_matches(param[:lowest_acceptable_price]) 
        return nil unless results.length > 0
        return results
    end

    def self.start_address_matches
        near(@start_addr, 1, latitude: :start_lat, longitude: :start_lon)
    end

    def self.end_address_matches
        near(@end_addr, 1, latitude: :end_lat, longitude: :end_lon)
    end

    def self.time_matches(param_time)
        date_time = param_time.to_s.to_datetime
        puts param_time
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
    def geocode_distance
        self.trip_distance = Geocoder::Calculations.distance_between([self.start_lat, self.start_lon], [self.end_lat, self.end_lon])
    end

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