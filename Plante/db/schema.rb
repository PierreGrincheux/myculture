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

ActiveRecord::Schema.define(version: 20160405194830) do

  create_table "control_cards", force: :cascade do |t|
    t.text "serial_nbr", limit: 65535
  end

  create_table "data_cards", force: :cascade do |t|
    t.text "serial_nbr", limit: 65535
  end

  create_table "media_files", force: :cascade do |t|
    t.text "title",       limit: 65535
    t.text "description", limit: 65535
    t.text "path",        limit: 65535
  end

  create_table "schools", force: :cascade do |t|
    t.text "name",         limit: 65535
    t.text "adress",       limit: 65535
    t.text "zip_code",     limit: 65535
    t.text "town",         limit: 65535
    t.text "phone_number", limit: 65535
    t.text "email",        limit: 65535
    t.text "contact",      limit: 65535
    t.text "description",  limit: 65535
  end

  create_table "target_values", force: :cascade do |t|
    t.float   "value",  limit: 24
    t.boolean "active"
  end

  create_table "users", force: :cascade do |t|
    t.text     "login",                  limit: 65535
    t.text     "password",               limit: 65535
    t.string   "email",                  limit: 255,   default: "",    null: false
    t.string   "encrypted_password",     limit: 255,   default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "failed_attempts",        limit: 4,     default: 0,     null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.boolean  "teacher",                              default: false
    t.boolean  "super_admin",                          default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "value_types", force: :cascade do |t|
    t.text "name", limit: 65535
  end

  create_table "values", force: :cascade do |t|
    t.float "value", limit: 24
  end

end
