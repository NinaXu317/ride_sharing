class Request < ApplicationRecord
    has_many :users, :through => :makes
    has_one :availability
end
