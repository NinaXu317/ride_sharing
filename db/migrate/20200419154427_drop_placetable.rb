class DropPlacetable < ActiveRecord::Migration[6.0]
  def up
    drop_table :places
  end

  def down 
    fail ActiveRecord::IrreversibleMigration
  end
end
