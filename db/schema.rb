# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_01_09_234103) do
  create_table "weather_forecasts", force: :cascade do |t|
    t.integer "zip_code_id", null: false
    t.decimal "current_temp", null: false
    t.decimal "high_temp"
    t.decimal "low_temp"
    t.datetime "date", null: false
    t.string "condition"
    t.string "condition_icon"
    t.string "feels_like"
    t.string "wind_speed"
    t.string "last_updated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["zip_code_id"], name: "index_weather_forecasts_on_zip_code_id"
  end

  create_table "zip_codes", force: :cascade do |t|
    t.string "code", null: false
    t.string "city"
    t.string "state"
    t.decimal "latitude"
    t.decimal "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_zip_codes_on_code", unique: true
  end

  add_foreign_key "weather_forecasts", "zip_codes"
end
