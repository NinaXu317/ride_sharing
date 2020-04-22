class Request < ApplicationRecord
    defaults trip_distance: 0.0, matched_availability_id: -1, request_status: "started", matched_user_id: -1
    has_many :users, :through => :makes
    has_one :availability
    scope :unmatched, ->{ where(matched_availability_id: -1) }
    scope :started, -> { where(request_status: "started")}
    geocoded_by :start_street_address, :latitude => :start_lat, :longitude => :start_lon
    geocoded_by :end_street_address, :latitude => :end_lat, :longitude => :end_lon
    before_save :geocode_end
    before_save :geocode_distance
    after_validation :geocode

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
