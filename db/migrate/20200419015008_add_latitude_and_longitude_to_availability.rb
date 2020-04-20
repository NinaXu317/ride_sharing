class AddLatitudeAndLongitudeToAvailability < ActiveRecord::Migration[6.0]
  def change
    add_column :availabilities, :start_lat, :float
    add_column :availabilities, :start_lon, :float
    add_column :availabilities, :end_lat, :float
    add_column :availabilities, :end_lon, :float
  end
end
