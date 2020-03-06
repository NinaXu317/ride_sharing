json.extract! availability, :id, :user_id, :start_city, :start_street_address, :start_zip, :end_city, :end_street_address, :end_zip, :trip_date, :trip_time, :distance, :lowest_acceptable_price, :matched_request_id, :availability_status, :created_at, :updated_at
json.url availability_url(availability, format: :json)
