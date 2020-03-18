class RemoveUseridFromAvailabilities < ActiveRecord::Migration[6.0]
  def change

    remove_column :availabilities, :user_id, :integer
  end
end
