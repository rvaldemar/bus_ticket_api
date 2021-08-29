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

ActiveRecord::Schema.define(version: 2021_08_29_162248) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buses", force: :cascade do |t|
    t.integer "seats", default: 49, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "routes", force: :cascade do |t|
    t.bigint "bus_id", null: false
    t.bigint "start_id", null: false
    t.bigint "destination_id", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bus_id"], name: "index_routes_on_bus_id"
    t.index ["destination_id"], name: "index_routes_on_destination_id"
    t.index ["start_id"], name: "index_routes_on_start_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.bigint "route_id", null: false
    t.jsonb "payment_details", null: false
    t.string "status", null: false
    t.integer "seat_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["route_id"], name: "index_tickets_on_route_id"
  end

  add_foreign_key "routes", "buses"
  add_foreign_key "routes", "cities", column: "destination_id"
  add_foreign_key "routes", "cities", column: "start_id"
  add_foreign_key "tickets", "routes"
end
