class Vehicle < ApplicationRecord
    belongs_to :user

    defaults number_of_rating_given: 0, sum_of_rating_given: 0, number_of_rating_received: 0, sum_of_rating_received: 0

end
