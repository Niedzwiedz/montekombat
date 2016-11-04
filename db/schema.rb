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

ActiveRecord::Schema.define(version: 20161103164257) do

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
    t.integer  "winner_id"
    t.integer  "round_id"
    t.integer  "creator_id",                   null: false
    t.integer  "points_for_team1", default: 0
    t.integer  "points_for_team2", default: 0
    t.datetime "date"
    t.integer  "match_type",       default: 0
    t.integer  "status",           default: 0
    t.index ["creator_id"], name: "index_matches_on_creator_id", using: :btree
    t.index ["game_id"], name: "index_matches_on_game_id", using: :btree
    t.index ["round_id"], name: "index_matches_on_round_id", using: :btree
    t.index ["team_1_id"], name: "index_matches_on_team_1_id", using: :btree
    t.index ["team_2_id"], name: "index_matches_on_team_2_id", using: :btree
    t.index ["winner_id"], name: "index_matches_on_winner_id", using: :btree
  end

  create_table "rounds", force: :cascade do |t|
    t.integer "tournament_id", null: false
    t.integer "round_number"
    t.index ["tournament_id"], name: "index_rounds_on_tournament_id", using: :btree
  end

  create_table "team_users", force: :cascade do |t|
    t.integer "team_id", null: false
    t.integer "user_id", null: false
    t.index ["team_id", "user_id"], name: "index_team_users_on_team_id_and_user_id", unique: true, using: :btree
    t.index ["team_id"], name: "index_team_users_on_team_id", using: :btree
    t.index ["user_id"], name: "index_team_users_on_user_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.integer "tournament_id", null: false
    t.string  "name"
    t.index ["tournament_id"], name: "index_teams_on_tournament_id", using: :btree
  end

  create_table "tournaments", force: :cascade do |t|
    t.integer  "game_id",                               null: false
    t.integer  "creator_id",                            null: false
    t.integer  "winner_id"
    t.string   "title",                                 null: false
    t.integer  "number_of_teams",                       null: false
    t.integer  "status",                    default: 0
    t.integer  "tournament_type",           default: 0
    t.integer  "number_of_players_in_team",             null: false
    t.text     "description"
    t.datetime "start_date",                            null: false
    t.string   "tournament_picture"
    t.index ["creator_id"], name: "index_tournaments_on_creator_id", using: :btree
    t.index ["game_id"], name: "index_tournaments_on_game_id", using: :btree
    t.index ["winner_id"], name: "index_tournaments_on_winner_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string  "username",                    null: false
    t.string  "email",                       null: false
    t.string  "firstname"
    t.string  "lastname"
    t.string  "password_digest"
    t.integer "account_type",    default: 0
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  create_table "winners", force: :cascade do |t|
    t.integer "team_id"
    t.index ["team_id"], name: "index_winners_on_team_id", using: :btree
  end

end
