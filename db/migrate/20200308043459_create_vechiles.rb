class CreateVechiles < ActiveRecord::Migration[6.0]
  def change
    create_table :vechiles do |t|
      t.integer :user_id
      t.string :license_number
      t.string :vehicle_make
      t.string :vehicle_model
      t.string :vehicle_plate

      t.timestamps
    end
  end
end
