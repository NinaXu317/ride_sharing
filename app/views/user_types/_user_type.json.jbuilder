json.extract! user_type, :id, :user_id, :is_driver, :created_at, :updated_at
json.url user_type_url(user_type, format: :json)
