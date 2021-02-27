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

ActiveRecord::Schema.define(version: 2021_02_27_171421) do

  create_table "tickers", force: :cascade do |t|
    t.string "symbol", null: false
    t.float "open"
    t.float "close"
    t.integer "volume"
    t.float "high"
    t.float "low"
    t.date "latest_trading_day"
    t.float "change_percent"
    t.float "change"
    t.float "previous_close"
    t.float "price"
    t.datetime "last_fetch_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
