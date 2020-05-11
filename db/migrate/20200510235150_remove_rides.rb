class RemoveRides < ActiveRecord::Migration[6.0]
  def change
    drop_table :rides
  end
end
