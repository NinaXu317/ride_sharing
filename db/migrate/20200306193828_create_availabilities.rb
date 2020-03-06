class CreateAvailabilities < ActiveRecord::Migration[6.0]
  def change
    create_table :availabilities do |t|
      t.integer :user_id
      t.string :start_city
      t.string :start_street_address
      t.string :start_zip
      t.string :end_city
      t.string :end_street_address
      t.string :end_zip
      t.date :trip_date
      t.datetime :trip_time
      t.float :distance
      t.float :lowest_acceptable_price
      t.integer :matched_request_id
      t.string :availability_status

      t.timestamps
    end
  end
end
