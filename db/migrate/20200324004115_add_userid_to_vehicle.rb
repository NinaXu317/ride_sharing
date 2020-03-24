class AddUseridToVehicle < ActiveRecord::Migration[6.0]
  def change
    add_column :vehicles, :user_id, :integer
  end
end
