class RemoveAddressFromRequest < ActiveRecord::Migration[6.0]
  def change

    remove_column :requests, :start_city, :string

    remove_column :requests, :start_zip, :string

    remove_column :requests, :end_city, :string

    remove_column :requests, :end_zip, :string
  end
end
