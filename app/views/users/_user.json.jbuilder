json.extract! user, :id, :username, :address, :age, :gender, :created_at, :updated_at
json.url user_url(user, format: :json)
