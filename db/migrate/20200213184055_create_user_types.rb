class CreateUserTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :user_types do |t|
      t.integer :user_id
      t.boolean :is_driver

      t.timestamps
    end
  end
end
