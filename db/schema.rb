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

ActiveRecord::Schema.define(version: 20160228143428) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fingerprints", force: :cascade do |t|
    t.string   "fingerprint"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "track_id"
    t.string   "title"
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "fingerprint_id"
    t.integer  "url_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "radio_id"
  end

  add_index "matches", ["fingerprint_id"], name: "index_matches_on_fingerprint_id", using: :btree
  add_index "matches", ["radio_id"], name: "index_matches_on_radio_id", using: :btree
  add_index "matches", ["url_id"], name: "index_matches_on_url_id", using: :btree

  create_table "radios", force: :cascade do |t|
    t.string   "name"
    t.string   "uri"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "urls", force: :cascade do |t|
    t.string   "url"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "matches", "fingerprints"
  add_foreign_key "matches", "radios"
  add_foreign_key "matches", "urls"
end
