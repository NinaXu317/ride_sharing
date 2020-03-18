class DeleteDateFromAvailabilities < ActiveRecord::Migration[6.0]
  def change
    remove_column :availabilities, :trip_date, :date
  end
end
