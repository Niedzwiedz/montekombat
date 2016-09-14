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

ActiveRecord::Schema.define(version: 20160905122621) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string "name",         null: false
    t.string "game_picture"
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "game_id",                      null: false
    t.integer  "team_1_id",                    null: false
    t.integer  "team_2_id",                    null: false
    t.integer  "points_for_team1", default: 0
    t.integer  "points_for_team2", default: 0
    t.datetime "date"
    t.integer  "match_type",       default: 0
    t.integer  "status",           default: 0
    t.index ["game_id"], name: "index_matches_on_game_id", using: :btree
    t.index ["team_1_id"], name: "index_matches_on_team_1_id", using: :btree
    t.index ["team_2_id"], name: "index_matches_on_team_2_id", using: :btree
  end

  create_table "team_users", force: :cascade do |t|
    t.integer "team_id", null: false
    t.integer "user_id", null: false
    t.index ["team_id", "user_id"], name: "index_team_users_on_team_id_and_user_id", unique: true, using: :btree
    t.index ["team_id"], name: "index_team_users_on_team_id", using: :btree
    t.index ["user_id"], name: "index_team_users_on_user_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string  "username",                 null: false
    t.string  "email"
    t.string  "firstname"
    t.string  "lastname"
    t.string  "password"
    t.integer "account_type", default: 0
  end

end
