class UpdateUserTable < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_send_notification, :boolean
  end
end
