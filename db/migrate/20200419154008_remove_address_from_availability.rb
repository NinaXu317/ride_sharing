class RemoveAddressFromAvailability < ActiveRecord::Migration[6.0]
  def change

    remove_column :availabilities, :start_city, :string

    remove_column :availabilities, :start_zip, :string

    remove_column :availabilities, :end_city, :string

    remove_column :availabilities, :end_zip, :string
  end
end
