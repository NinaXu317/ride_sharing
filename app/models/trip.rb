class Trip < ApplicationRecord
  defaults request_id: -10
  scope :upcoming, -> { where(status: "confirmed")}
  scope :completed, -> { where(status: "completed")}

  def self.find_by_driver (driver_id)
    where("driver_id = ? ", driver_id)
  end

  def self.find_by_rider (rider_id)
    where("rider_id = ? ", rider_id)
  end

  def self.find_closest_ride user_id
    rides = Ride.find_by_driver_id(user_id)
    rides.sort! {|a, b| a.trip_time <=> b.trip_time}
    return rides[0]
  end

end

