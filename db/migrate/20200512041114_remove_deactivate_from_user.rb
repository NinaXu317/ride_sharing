class RemoveDeactivateFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :deactivated
  end
end
