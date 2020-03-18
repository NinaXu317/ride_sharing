class DeleteDateFromRequests < ActiveRecord::Migration[6.0]
  def change
    remove_column :requests, :trip_date, :date
  end
end
