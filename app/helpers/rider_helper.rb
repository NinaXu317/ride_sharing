module RiderHelper

  def rate_user(driver, rider, trip, rating)
    if trip.request_id != -1
      request = Request.find(trip.request_id)
      request.request_status = "completed"
    end
    if trip.availability_id != -1
      availability = Availability.find(trip.availability_id)
      availability.availability_status = "completed"
    end
    driver.number_of_rating_received += 1
    driver.sum_of_rating_received += rating
    rider.number_of_rating_given += 1
    rider.sum_of_rating_given += rating
    driver.save
    rider.save
    trip.status = "completed"
    trip.save
  end

end
