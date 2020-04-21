class ChangeDistanceToAvailability < ActiveRecord::Migration[6.0]
  def change
    rename_column :availabilities, :distance, :trip_distance
  end
end
