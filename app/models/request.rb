class Request < ApplicationRecord
    defaults trip_distance: 0.0, matched_availability_id: -1, request_status: "started", matched_user_id: -1
    default_scope { order("created_at DESC") }
    has_one :user, :through => :makes
    has_many :makes, dependent: :destroy
    has_one :availability
    has_many :rides, foreign_key: :request_id
    default_scope { includes(:makes) }
    scope :unmatched, ->{ where(request_status: "started").where("trip_time >= ?", Time.now) }
    scope :started, -> { where(request_status: "started").where("trip_time >= ?", Time.now)}
    scope :waiting, -> { where(request_status: "waiting").where("trip_time >= ?", Time.now)}
    scope :upcoming, -> { where(request_status: "confirmed").where("trip_time >= ?", Time.now)}
    scope :completed, -> { where(request_status: "completed")}
    scope :canceled, -> { where(request_status: "conceled")}
    geocoded_by :start_street_address, :latitude => :start_lat, :longitude => :start_lon
    geocoded_by :end_street_address, :latitude => :end_lat, :longitude => :end_lon
    before_save :geocode_end
    before_save :geocode_distance
    after_validation :geocode
    paginates_per 24

    def self.search (param)
        @start_addr = param[:start_street_address]
        @end_addr = param[:end_street_address]
        @start_coord = Geocoder.coordinates(@start_addr)
        @end_coord = Geocoder.coordinates(@end_addr)
        results = Request.all
        final_res = []
        if !param[:trip_time].empty?
            results = results.time_matches(param[:trip_time])
        end
        if !param[:highest_price_to_pay].empty?
            results = results.price_matches(param[:highest_price_to_pay])
        end
        if !@start_addr.empty?
            res = start_address_matches(results)
        end
        if !@end_addr.empty?
            final_res = results.start_address_matches(res)
        end
        return nil unless final_res.length > 0
        return Request.where(id: final_res.map(&:id))
    end

    def self.start_address_matches res
        filtered = []
        res.each do |r|
            if Geocoder::Calculations.distance_between(@start_coord, [r.start_lat, r.start_lon]) < 1
                filtered << r
            end
        end
        return filtered
    end

    def self.end_address_matches res
        filtered = []
        res.each do |r|
            if Geocoder::Calculations.distance_between(@end_coord, [r.end_lat, r.end_lon]) < 1
                filtered << r
            end
        end
        return filtered
    end

    def self.time_matches(param_time)
        date_time = param_time.to_s.to_datetime
        puts param_time
        before = date_time - (0.25 / 24.0)
        after = date_time + (0.25 / 24.0)
        where("trip_time BETWEEN ? AND ? ", before, after)
    end

    def self.price_matches(param_price)
        low = param_price.to_i - 5
        high = param_price.to_i + 5
        where("highest_price_to_pay BETWEEN ? AND ? ", low, high)
    end

    def self.find_closest_request user_id
        requests = Request.find_request_by_user_id(user_id)
        requests.sort! {|a, b| a.trip_time <=> b.trip_time}
        return requests[0]
    end

    def self.find_request_by_user_id user_id
        make = Make.find_user_id(user_id)
        requests_result = []
        make.each do |m|
            if !Request.find_by(id: m.request_id).nil?
                requests_result << Request.find_by(id: m.request_id)
            end
        end
        return requests_result
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
