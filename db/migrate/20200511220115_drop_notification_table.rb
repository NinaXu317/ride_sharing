class DropNotificationTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :notifications
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
