# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# address_list = []
def create_user
    (0...100).each do
        randome_name
        User.create(username: Faker::GreekPhilosophers, email: Faker::Internet.email, age: random_age, gender: Faker::Gender, firstname: @firstname, lastname: @lastname,
        phone_numer: Faker::PhoneNumber, major: random_major, year: "", is_driver: is_driver(Random.rand(0..100)), number_of_rating_give: 0, number_of_rating_received: 0,
        sum_of_rating_given: 0, sum_of_rating_received: 0)
    end
end

def create_availability
    (0..100).each do
        Availability.create(start_city: None, start_street_address: None, start_zip: None, end_city: None, end_street_address: None, end_zip: None, trip_date: Faker::Date, trip_time: None,
        distance: 0, lowest_acceptable_price: get_random_price, matched_request_id: -1, availability_status: None)
    end
end

def create_request
    (0..100).each do
        Request.create(start_city: None, start_street_address: None, start_zip: None, end_city: None, end_street_address: None, end_zip: None, trip_date: Faker::Date, trip_time: None,
        distance: 0, highest_price_to_pay: get_random_price, matched_availability_id: -1, request_status: None)
    end
end

def create_vehicle
    (0..100).each do
        Vehicle.create(user_id: -1, license_number:, vehicle_make:, vehicle_model:)
    end
end

def get_random_price
    Random.rand(0.0, 20.0)
end

def random_age
    Random.rand(17..50)
end

def random_major
    majors = [
        "", 
        "Economics", "",
        "Computer Science", "Art History", "Biology", "Physics", "Mathematics", 
        "Chemistry", "", "Fine Arts", "Business",
        "English",
        "",
    ]
    len = majors.size
    majors[Random.rand(0..len - 1)]
end

def random_year 
    years = [
        "",
        "freshman",
        "sophomore",
        "junior", 
        "",
        "senior",
        "master", 
        "", 
        "phd",
        "postdoc",
    ]
end

def is_driver number
    if number % 2 == 1
        True
    else
        False
    end
end

def random_name
    random_name = Faker::Name.unique.name.strip.split(" ")
    @firstname = random_name[0]
    @lastname = random_name[1]
end

def random_vehicle
