class Request < ApplicationRecord
    defaults distance: 0.0, matched_availability_id: -1, request_status: "started"
    has_many :users, :through => :makes
    has_one :availability
    scope :unmatched, ->{ where(matched_availability_id: -1) }
end
