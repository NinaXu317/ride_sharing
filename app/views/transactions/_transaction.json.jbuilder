json.extract! transaction, :id, :rider_id, :driver_id, :post_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
