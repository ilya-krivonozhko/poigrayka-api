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

ActiveRecord::Schema[8.0].define(version: 2026_01_22_064412) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "title", limit: 50, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((title)::text)", name: "index_categories_on_lower_title", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.string "title", limit: 80, null: false
    t.integer "stock", null: false
    t.text "description", null: false
    t.string "short_description", limit: 150, null: false
    t.text "rules", null: false
    t.text "contents", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.integer "min_players", null: false
    t.integer "max_players", null: false
    t.integer "age_rating", null: false
    t.integer "play_time", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((title)::text)", name: "index_products_on_lower_title"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["price"], name: "index_products_on_price"
    t.check_constraint "age_rating >= 0", name: "age_rating_non_negative"
    t.check_constraint "max_players > 0 AND max_players <= 100", name: "max_players_range"
    t.check_constraint "min_players <= max_players", name: "players_range_valid"
    t.check_constraint "min_players > 0", name: "min_players_positive"
    t.check_constraint "play_time > 0", name: "play_time_positive"
    t.check_constraint "price < 10000000::numeric", name: "price_upper_bound"
    t.check_constraint "price >= 0::numeric", name: "price_non_negative"
    t.check_constraint "stock >= 0", name: "stock_non_negative"
  end

  add_foreign_key "products", "categories"
end
