class UpdateIntegerLimit < ActiveRecord::Migration[6.0]
  def change
    change_column :curt_avails, :phone_number, :integer, limit: 8
  end
end
