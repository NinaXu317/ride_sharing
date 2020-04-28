class CreateRides < ActiveRecord::Migration[6.0]
  def change
    create_table :rides do |t|
      t.integer :driver_id
      t.integer :rider_id
      t.integer :availability_id
      t.integer :request_id

      t.timestamps
    end
  end
end
