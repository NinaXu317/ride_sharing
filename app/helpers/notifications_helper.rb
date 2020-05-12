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
end
