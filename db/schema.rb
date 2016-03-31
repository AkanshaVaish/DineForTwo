# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160331033157) do

  create_table "people", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "uid"
    t.string   "image_url"
    t.string   "url"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.integer  "person_id"
    t.text     "company"
    t.text     "address"
    t.text     "bio"
    t.string   "avatar"
    t.string   "gender"
  end

  add_index "people", ["email"], name: "index_people_on_email", unique: true
  add_index "people", ["uid"], name: "index_people_on_uid", unique: true

  create_table "people_restaurants", id: false, force: :cascade do |t|
    t.integer "person_id"
    t.integer "restaurant_id"
  end

  add_index "people_restaurants", ["person_id"], name: "index_people_restaurants_on_person_id"
  add_index "people_restaurants", ["restaurant_id"], name: "index_people_restaurants_on_restaurant_id"

  create_table "reservations", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "restaurant_id"
    t.datetime "reservation_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reservations", ["person_id", "restaurant_id"], name: "index_reservations_on_person_id_and_restaurant_id", unique: true
  add_index "reservations", ["person_id"], name: "index_reservations_on_person_id"
  add_index "reservations", ["restaurant_id"], name: "index_reservations_on_restaurant_id"

  create_table "restaurants", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
