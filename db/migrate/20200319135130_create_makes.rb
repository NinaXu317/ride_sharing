class CreateMakes < ActiveRecord::Migration[6.0]
  def change
    create_table :makes do |t|
      t.integer :user_id
      t.integer :request_id

      t.timestamps
    end
  end
end
