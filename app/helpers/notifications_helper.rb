module NotificationsHelper

  def find_messages type
    if type == "pickup_start"
      return "Your driver is heading to your direction"
    end
    if type == "pickup_arrival"
      return "Your driver has arrived at your location, please meet your driver outside"
    end
    if type == "trip_start"
      return "Your trip has started"
    end
    if type == "trip_end"
      return "Your trip has completed"
    end
  end

  def find_messages_rider type
    if type == "at_start"
      return "I have arrived at your start location"
    end
  end

  def send_cancellation_message(tc, rider, driver, trip)
    if trip.request_id == -1
      availability = Availability.find(trip.availability_id)
      rider_message = cancel_message(availability, rider)
      tc.send_text(rider, rider_message)
      driver_message = cancel_message(availability, driver)
      tc.send_text(driver, driver_message)
    else
      request = Request.find(trip.request_id)
      rider_message = cancel_message(request, rider)
      tc.send_text(rider, rider_message)
      driver_message = cancel_message(request, driver)
      tc.send_text(driver, driver_message)
    end
  end

  def cancel_message type, person_cancels
    if person_cancels.id == current_user.id
      message = "Your trip starting at #{type.start_street_address} and ending at #{type.end_street_address} at #{type.trip_time} has been canceled"
    else
      if person_cancels.is_driver
        message = "Your trip starting at #{type.start_street_address} and ending at #{type.end_street_address} at #{type.trip_time} has been canceled by your driver"
      else
        message = "Your trip starting at #{type.start_street_address} and ending at #{type.end_street_address} at #{type.trip_time} has been canceled by your rider"
      end
    end
    return message
  end

end
