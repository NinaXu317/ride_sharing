class Vehicle < ApplicationRecord
    belongs_to :user

    defaults license_number: "", vehicle_make: "", vehicle_model: "", vehicle_color: "", vehicle_plate: ""

end
