module RiderHelper

  def rate_user(driver, rider, trip, rating)
    driver.number_of_rating_received += 1
    driver.sum_of_rating_received += rating
    rider.number_of_rating_given += 1
    rider.sum_of_rating_given += rating
    driver.save
    rider.save
    trip.status = "completed"
  end

end
