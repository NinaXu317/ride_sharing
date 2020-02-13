class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.integer :post_id
      t.integer :user_id
      t.string :start
      t.string :destination
      t.string :trip_date
      t.string :trip_time
      t.float :distance

      t.timestamps
    end
  end
end
