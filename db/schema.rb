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

ActiveRecord::Schema.define(version: 20140606002052) do

  create_table "survey_responses", force: true do |t|
    t.string   "uuid",                  limit: 40
    t.string   "food_description",      limit: 100
    t.string   "zip_code",              limit: 5
    t.decimal  "latitude",                          precision: 10, scale: 6
    t.decimal  "longitude",                         precision: 10, scale: 6
    t.boolean  "prepared"
    t.boolean  "opened"
    t.boolean  "dangerous_temperature"
    t.boolean  "old"
    t.boolean  "distressed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "completed",                                                  default: false, null: false
    t.string   "respondent_ip",         limit: 45
  end

end
