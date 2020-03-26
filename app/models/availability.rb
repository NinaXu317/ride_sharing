class Availability < ApplicationRecord
    has_many :users, :through => :posts
    has_one :request
    scope :unmatched, ->{ where(matched_request_id: -1) }

    def self.search (params)
        puts "start searching"
        results = city_matches(start_city, end_city, params[:start_city], params[:end_city]) 
        return nil unless results
        results
    end

    def self.city_matches(start_param, end_param, start_name, end_name)
        where("#{start_param} = ? AND #{end_param} = ?", *["%#{start_name}", "%#{end_name}"])
    end

    def self.time_matches(given_time)
        request_time = given_time.to_time
        before = request_time - (0.5 / 24)
        after = reqeust_time + (0.5 / 24)
        where("triptime BETWEEN ? AND ? ", before, after)
    end
end