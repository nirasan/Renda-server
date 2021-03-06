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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130304062751) do

  create_table "rankings", :force => true do |t|
    t.string   "category"
    t.integer  "user_id"
    t.integer  "count"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "token_pairs", :force => true do |t|
    t.string   "access_token"
    t.integer  "expires_in"
    t.integer  "issued_at"
    t.string   "refresh_token"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "mail_address"
    t.string   "username"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "life",         :default => 0
    t.integer  "level",        :default => 1
    t.integer  "total_count",  :default => 0
    t.integer  "game_time",    :default => 5
  end

end
