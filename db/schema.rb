# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_19_135211) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "availabilities", force: :cascade do |t|
    t.string "start_city"
    t.string "start_street_address"
    t.string "start_zip"
    t.string "end_city"
    t.string "end_street_address"
    t.string "end_zip"
    t.datetime "trip_time"
    t.float "distance"
    t.float "lowest_acceptable_price"
    t.integer "matched_request_id"
    t.string "availability_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "makes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "request_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer "availability_id"
    t.integer "request_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "availability_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "requests", force: :cascade do |t|
    t.string "start_city"
    t.string "start_street_address"
    t.string "start_zip"
    t.string "end_city"
    t.string "end_street_address"
    t.string "end_zip"
    t.datetime "trip_time"
    t.float "distance"
    t.float "highest_price_to_pay"
    t.integer "matched_availability_id"
    t.string "request_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.integer "age"
    t.string "gender"
    t.string "firstname"
    t.string "lastname"
    t.string "phone_number"
    t.string "major"
    t.string "year"
    t.boolean "is_driver"
    t.integer "number_of_rating_given"
    t.integer "number_of_rating_received"
    t.integer "sum_of_rating_given"
    t.integer "sum_of_rating_received"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "license_number"
    t.string "vehicle_make"
    t.string "vehicle_model"
    t.string "vehicle_color"
    t.string "vehicle_plate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
