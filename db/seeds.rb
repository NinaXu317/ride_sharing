# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'faker'

User.delete_all
Post.delete_all
Make.delete_all
Availability.delete_all
Request.delete_all
Vehicle.delete_all

def create_user
    (0...50).each do
        @age = Faker::Number.within(range: 17..50)
        random_name = Faker::Name.unique.name.strip.split(" ")
        @firstname = random_name[0]
        @lastname = random_name[1]
        @year = get_year(@age)
        @is_driver = is_driver(rand(100))
        @major = random_major
        @user = User.create(username: Faker::Superhero.name, email: Faker::Internet.email, password: "111111", age: @age, gender: Faker::Gender.binary_type, firstname: @firstname, lastname: @lastname,
                            phone_number: Faker::Number.number(digits: 10), major: @major, year: @year, is_driver: @is_driver, number_of_rating_given: 0, number_of_rating_received: 0,
                            sum_of_rating_given: 0, sum_of_rating_received: 0)
        if @is_driver
            @vehicle_make = Faker::Vehicle.make
            @vehicle_model = Faker::Vehicle.model(make_of_model: @vehicle_make)
            @user.vehicle = Vehicle.create(license_number: Faker::Alphanumeric.alpha(number: 9), vehicle_make: @vehicle_make, vehicle_model: @vehicle_model, vehicle_plate: Faker::Vehicle.license_plate, vehicle_color: Faker::Color.color_name)
        end
    end
    puts "generated user and vehicle data"
end

# status: started, waiting, confirmed, canceled, complete
def create_availability
    (0...50).each do
        if rand(100) % 2 == 0     
            @start_street_address = brandeis_location
            @end_street_address = street_map
        else 
            @start_street_address = street_map
            @end_street_address = brandeis_location
        end
        @date = Faker::Time.between_dates(from: Date.today + 20, to: Date.today + 365, period: :day)
        Availability.create(start_street_address: @start_street_address, end_street_address: @end_street_address, trip_time: @date, lowest_acceptable_price: Faker::Number.within(range: 17..50), matched_request_id: -1, availability_status: "started")
    end
    puts "generated availability data"
end

def create_request
    (0...50).each do
        if rand(100) % 2 == 0      
            @start_street_address = brandeis_location
            @end_street_address = street_map
        else 
            @start_street_address = street_map
            @end_street_address = brandeis_location
        end
        @date = Faker::Time.between_dates(from: Date.today + 20, to: Date.today + 365, period: :day)
        Request.create(start_street_address: @start_street_address, end_street_address: @end_street_address, trip_time: @date, highest_price_to_pay: Faker::Number.within(range: 17..50), matched_availability_id: -1, request_status: "started")
    end
    puts "generated request data"
end

private 
# generate year according to age
def get_year age
    if age <= 17 or age > 40
        return ""
    elsif age <= 19
        return "freshman"
    elsif age <= 20
        return "sophmore"
    elsif age <= 21
        return "junior"
    elsif age <= 22
        return "senior"
    elsif age <= 26
        return "master"
    elsif age <= 35
        return "phd"
    elsif age <= 40
        return "postdoc"
    end
end

# generate brandeis location
def brandeis_location
    return "415 South Street, Waltham, MA, 02453"
end

# generate majors
def random_major
    majors = [
        "", 
        "Economics", "",
        "Computer Science", "Art History", "Biology", "Physics", "Mathematics", 
        "Chemistry", "", "Fine Arts", "Business",
        "English",
        "",
    ]
    majors[rand(majors.size - 1)]
end

# generate street address
def street_map
    street_list = [
        "1105 Lexington St, Waltham, MA, 02452", 
        "1036 Lexington St, Waltham, MA, 02452",
        "12 Marlborough Rd, Waltham, MA, 02452",
        "15 Middlesex Rd, Waltham, MA, 02452",
        "70 Middlesex Rd, Waltham, MA, 02452",
        "14 Dawes St, Waltham, MA, 02452",
        "15 Newburgh St, Waltham, MA, 02452",
        "556 Main St, Waltham, MA, 02453",
        "20 Fiske St, Waltham, MA, 02453",
        "44 Curtis St, Waltham, MA, 02453",
        "70 Hope Ave, Waltham, MA, 02453",
        "60 Hope Ave, Waltham, MA, 02453",
        "80 Hope Ave, Waltham, MA, 02453",
        "25 Crescent St, Waltham, MA, 02453"
    ]
    return street_list[rand(street_list.size - 1)]
end

# generate driver information
def is_driver number
    if number % 2 == 1
        true
    else
        false
    end
end

create_user
create_request
create_availability