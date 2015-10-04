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

ActiveRecord::Schema.define(version: 20151012090323) do

  create_table "lists", force: :cascade do |t|
    t.text     "title",      limit: 65535
    t.integer  "plan_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "plans", force: :cascade do |t|
    t.text     "title",       limit: 65535
    t.text     "description", limit: 65535
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "color_tag",   limit: 4,     default: 1
  end

  create_table "tasks", force: :cascade do |t|
    t.text     "title",       limit: 65535
    t.text     "description", limit: 65535
    t.integer  "status",      limit: 4,     default: 1
    t.integer  "list_id",     limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "plan_id",     limit: 4
  end

end
