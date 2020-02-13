class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.integer :rider_id
      t.integer :driver_id
      t.integer :post_id

      t.timestamps
    end
  end
end
