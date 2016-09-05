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

  create_table "games", force: :cascade do |t|
    t.string "name"
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "team_1_id"
    t.integer  "team_2_id"
    t.integer  "points_for_team1"
    t.integer  "points_for_team2"
    t.datetime "date"
    t.index ["game_id"], name: "index_matches_on_game_id"
    t.index ["team_1_id"], name: "index_matches_on_team_1_id"
    t.index ["team_2_id"], name: "index_matches_on_team_2_id"
  end

  create_table "team_users", force: :cascade do |t|
    t.integer "team_id"
    t.integer "user_id"
    t.index ["team_id"], name: "index_team_users_on_team_id"
    t.index ["user_id"], name: "index_team_users_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "firstname"
    t.string "lastname"
  end

end
