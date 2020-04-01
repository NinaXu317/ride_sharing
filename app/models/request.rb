class Request < ApplicationRecord
    defaults distance: 0.0, matched_availability_id: -1, request_status: "started", matched_user_id: -1
    has_many :users, :through => :makes
    has_one :availability
    scope :unmatched, ->{ where(matched_availability_id: -1) }
    scope :started, -> { where(request_status: "started")}
end
