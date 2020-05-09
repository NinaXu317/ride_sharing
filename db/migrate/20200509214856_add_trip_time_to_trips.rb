class AddTripTimeToTrips < ActiveRecord::Migration[6.0]
  def change
    add_column :trips, :trip_time, :datetime
  end
end
