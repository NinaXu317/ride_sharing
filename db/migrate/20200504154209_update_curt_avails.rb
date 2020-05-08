class UpdateCurtAvails < ActiveRecord::Migration[6.0]
  def change
    remove_column :curt_avails, :phone_number
    add_column :curt_avails, :phone_number, :integer
  end
end
