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

ActiveRecord::Schema.define(version: 20180412102229) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "messages", force: :cascade do |t|
    t.bigint "user_id"
    t.text "content"
    t.bigint "volunteer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_messages_on_user_id"
    t.index ["volunteer_id"], name: "index_messages_on_volunteer_id"
  end

  create_table "requests", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.float "lat"
    t.float "lng"
    t.string "address"
    t.integer "status", default: 0
    t.integer "reqtype"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "identity"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "volunteers", force: :cascade do |t|
    t.bigint "request_id"
    t.bigint "user_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_id"], name: "index_volunteers_on_request_id"
    t.index ["user_id"], name: "index_volunteers_on_user_id"
  end

  add_foreign_key "messages", "users"
  add_foreign_key "messages", "volunteers"
  add_foreign_key "requests", "users"
  add_foreign_key "volunteers", "requests"
  add_foreign_key "volunteers", "users"
end
