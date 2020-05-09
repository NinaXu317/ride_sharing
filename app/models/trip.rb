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

end

