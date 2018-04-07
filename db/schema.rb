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

ActiveRecord::Schema.define(version: 20180407064453) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.string "type", null: false
    t.bigint "player_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "proof_file_name"
    t.string "proof_content_type"
    t.integer "proof_file_size"
    t.datetime "proof_updated_at"
    t.index ["player_id"], name: "index_achievements_on_player_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.bigint "venue_id", null: false
    t.datetime "start_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["venue_id"], name: "index_events_on_venue_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "games", force: :cascade do |t|
    t.bigint "venue_id", null: false
    t.bigint "season_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["season_id"], name: "index_games_on_season_id"
    t.index ["venue_id"], name: "index_games_on_venue_id"
  end

  create_table "games_players", force: :cascade do |t|
    t.bigint "game_id"
    t.bigint "player_id"
    t.integer "position", limit: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "score", default: 0, null: false
    t.index ["game_id", "player_id"], name: "index_games_players_on_game_id_and_player_id", unique: true
    t.index ["game_id"], name: "index_games_players_on_game_id"
    t.index ["player_id"], name: "index_games_players_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "username", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.integer "score", default: 0, null: false
    t.integer "games_played", default: 0, null: false
    t.integer "games_won", default: 0, null: false
    t.boolean "is_admin", default: false, null: false
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "notify_promotional", default: true, null: false
    t.boolean "notify_events", default: true, null: false
    t.index ["email"], name: "index_players_on_email", unique: true
    t.index ["reset_password_token"], name: "index_players_on_reset_password_token", unique: true
    t.index ["username"], name: "index_players_on_username", unique: true
  end

  create_table "players_regions", force: :cascade do |t|
    t.bigint "region_id"
    t.bigint "player_id"
    t.integer "score", default: 0, null: false
    t.integer "games_played", default: 0, null: false
    t.integer "games_won", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id", "region_id"], name: "index_players_regions_on_player_id_and_region_id", unique: true
    t.index ["player_id"], name: "index_players_regions_on_player_id"
    t.index ["region_id"], name: "index_players_regions_on_region_id"
  end

  create_table "players_seasons", force: :cascade do |t|
    t.bigint "season_id"
    t.bigint "player_id"
    t.integer "score", default: 0, null: false
    t.integer "games_played", default: 0, null: false
    t.integer "games_won", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id", "season_id"], name: "index_players_seasons_on_player_id_and_season_id", unique: true
    t.index ["player_id"], name: "index_players_seasons_on_player_id"
    t.index ["season_id"], name: "index_players_seasons_on_season_id"
  end

  create_table "players_venues", force: :cascade do |t|
    t.bigint "venue_id"
    t.bigint "player_id"
    t.integer "score", default: 0, null: false
    t.integer "games_played", default: 0, null: false
    t.integer "games_won", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id", "venue_id"], name: "index_players_venues_on_player_id_and_venue_id", unique: true
    t.index ["player_id"], name: "index_players_venues_on_player_id"
    t.index ["venue_id"], name: "index_players_venues_on_venue_id"
  end

  create_table "referees", force: :cascade do |t|
    t.bigint "game_id"
    t.bigint "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id", "player_id"], name: "index_referees_on_game_id_and_player_id", unique: true
    t.index ["game_id"], name: "index_referees_on_game_id"
    t.index ["player_id"], name: "index_referees_on_player_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "slug", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_regions_on_slug", unique: true
  end

  create_table "seasons", force: :cascade do |t|
    t.date "start_at", null: false
    t.date "end_at", null: false
  end

  create_table "venues", force: :cascade do |t|
    t.string "slug", null: false
    t.string "name", null: false
    t.bigint "region_id", null: false
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.string "address"
    t.string "suburb"
    t.integer "state", limit: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_venues_on_region_id"
    t.index ["slug"], name: "index_venues_on_slug", unique: true
  end

end
