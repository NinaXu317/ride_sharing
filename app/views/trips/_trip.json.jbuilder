json.extract! trip, :id, :driver_id, :rider_id, :availability_id, :request_id, :status, :created_at, :updated_at
json.url trip_url(trip, format: :json)
