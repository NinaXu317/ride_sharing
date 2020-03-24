class Availability < ApplicationRecord
    has_many :users, :through => :posts
    has_one :request
end