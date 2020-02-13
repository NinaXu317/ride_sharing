json.extract! post, :id, :post_id, :user_id, :start, :destination, :trip_date, :trip_time, :distance, :created_at, :updated_at
json.url post_url(post, format: :json)
