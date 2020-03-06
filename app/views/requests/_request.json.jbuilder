json.extract! request, :id, :user_id, :start_city, :start_street_address, :start_zip, :end_city, :end_street_address, :end_zip, :trip_date, :trip_time, :distance, :highest_price_to_pay, :matched_availability_id, :request_status, :created_at, :updated_at
json.url request_url(request, format: :json)
