class Availability < ApplicationRecord
    has_many :users, :through => :posts
    has_one :request
    scope :unmatched, ->{ where(matched_request_id: -1) }
end