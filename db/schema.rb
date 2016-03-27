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

ActiveRecord::Schema.define(version: 20160327221419) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "average_high_temperatures", force: :cascade do |t|
    t.integer  "cities_id"
    t.integer  "months_id"
    t.decimal  "temperature"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "average_low_temperatures", force: :cascade do |t|
    t.integer  "cities_id"
    t.integer  "months_id"
    t.decimal  "temperature"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "average_rainy_days", force: :cascade do |t|
    t.integer  "cities_id"
    t.integer  "months_id"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "average_relative_humidities", force: :cascade do |t|
    t.integer  "cities_id"
    t.integer  "months_id"
    t.integer  "percent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "country"
    t.string   "region"
    t.string   "internet_download_speed"
    t.string   "wiki_slug"
    t.string   "flickr_tag"
    t.integer  "search_hits"
  end

  create_table "costs", force: :cascade do |t|
    t.integer  "cities_id"
    t.decimal  "airbnb_median"
    t.decimal  "airbnb_vs_apartment_price_ratio"
    t.decimal  "beer_in_cafe"
    t.decimal  "coffee_in_cafe"
    t.decimal  "hotel"
    t.decimal  "non_alcoholic_drink_in_cafe"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "daily_mean_temperatures", force: :cascade do |t|
    t.integer  "cities_id"
    t.integer  "months_id"
    t.decimal  "temperature"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "featured_images", force: :cascade do |t|
    t.integer  "cities_id"
    t.string   "px250"
    t.string   "px500"
    t.string   "px1000"
    t.string   "px1500"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ideal_months", force: :cascade do |t|
    t.integer  "cities_id"
    t.integer  "months_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "months", force: :cascade do |t|
    t.string "name"
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "cities_id"
    t.string   "title"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scores", force: :cascade do |t|
    t.integer  "cities_id"
    t.decimal  "nightlife"
    t.decimal  "safety"
    t.decimal  "free_wifi_available"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
