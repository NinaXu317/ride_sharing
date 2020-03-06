class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.integer :age
      t.string :gender
      t.string :firstname
      t.string :lastname
      t.string :phone_number
      t.string :major
      t.string :year
      t.boolean :is_driver
      t.integer :number_of_rating_given
      t.integer :number_of_rating_received
      t.integer :sum_of_rating_given
      t.integer :sum_of_rating_received

      t.timestamps
    end
  end
end
