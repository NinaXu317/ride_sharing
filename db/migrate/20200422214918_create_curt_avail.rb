class CreateCurtAvail < ActiveRecord::Migration[6.0]
  def change
    create_table :curt_avails do |t|
      t.string :phone_number
      t.integer :availability_id
    end
  end
end
