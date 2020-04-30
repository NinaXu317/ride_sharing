class Ride < ApplicationRecord
    defaults request_id: -10
    belongs_to :driver, class_name: "User"
    belongs_to :rider, class_name: "User"
    ratyrate_rater
end
