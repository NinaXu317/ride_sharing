class CreateVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicles do |t|
      t.string :license_number
      t.string :vehicle_make
      t.string :vehicle_model
      t.string :vehicle_color
      t.string :vehicle_plate

      t.timestamps
    end
  end
end
