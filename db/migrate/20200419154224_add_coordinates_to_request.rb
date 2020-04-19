class AddCoordinatesToRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :start_lat, :float
    add_column :requests, :start_lon, :float
    add_column :requests, :end_lat, :float
    add_column :requests, :end_lon, :float
  end
end
