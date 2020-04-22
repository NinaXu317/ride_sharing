class ChangeDistanceToRequest < ActiveRecord::Migration[6.0]
  def change
    rename_column :requests, :distance, :trip_distance
  end
end
