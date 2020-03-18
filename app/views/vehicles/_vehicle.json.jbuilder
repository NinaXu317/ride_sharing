json.extract! vehicle, :id, :license_number, :vehicle_make, :vehicle_model, :vehicle_color, :vehicle_plate, :created_at, :updated_at
json.url vehicle_url(vehicle, format: :json)
