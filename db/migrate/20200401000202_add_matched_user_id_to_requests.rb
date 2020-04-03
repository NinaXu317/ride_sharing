class AddMatchedUserIdToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :matched_user_id, :integer
  end
end
