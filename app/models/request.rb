class Request < ApplicationRecord
    has_many :users, :through => :makes
    has_one :availability
    scope :unmatched, ->{ where(matched_availability_id: -1) }
end
