json.extract! user, :id, :username, :email, :age, :gender, :firstname, :lastname, :phone_number, :major, :year, :is_driver, :number_of_rating_given, :number_of_rating_received, :sum_of_rating_given, :sum_of_rating_received, :created_at, :updated_at
json.url user_url(user, format: :json)
