class Trip < ApplicationRecord
  defaults request_id: -1
  default_scope { order("trip_time DESC") }
  scope :upcoming, -> { where(status: "confirmed")}
  scope :completed, -> { where(status: "completed")}

  def self.find_closest_ride user_id
    ride = Trip.find_by_driver(user_id)
    res = ride.where("trip_time >= ?", Date.today).order("trip_time ASC")
    return res.first
  end

  def self.find_by_driver (driver_id)
    where("driver_id = ? ", driver_id)
  end

  def self.find_by_rider (rider_id)
    where("rider_id = ? ", rider_id)
  end

end

