class Match < ApplicationRecord
    belongs_to :availability
    belongs_to :request
end
