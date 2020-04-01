class AddMatchedUserIdToAvailabilities < ActiveRecord::Migration[6.0]
  def change
    add_column :availabilities, :matched_user_id, :integer
  end
end
