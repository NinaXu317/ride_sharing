class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.integer :availability_id
      t.integer :request_id

      t.timestamps
    end
  end
end
