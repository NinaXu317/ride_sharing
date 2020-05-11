class DropNotificationsTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :notifications
  end
end
