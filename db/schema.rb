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

ActiveRecord::Schema.define(version: 20180210100504) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "communication_data", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "type"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_communication_data_on_user_id"
  end

  create_table "devices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "push_token"
    t.string "user_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_devices_on_user_id"
  end

  create_table "league_matches", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "swiper_id"
    t.uuid "target_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["swiper_id"], name: "index_league_matches_on_swiper_id"
    t.index ["target_id"], name: "index_league_matches_on_target_id"
  end

  create_table "league_messages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "content"
    t.uuid "league_match_id"
    t.uuid "league_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_match_id"], name: "index_league_messages_on_league_match_id"
    t.index ["league_profile_id"], name: "index_league_messages_on_league_profile_id"
  end

  create_table "league_positions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "league_profile_id"
    t.string "rank"
    t.string "queue_type"
    t.boolean "hot_streak"
    t.integer "wins"
    t.boolean "veteran"
    t.integer "losses"
    t.boolean "fresh_blood"
    t.string "league_id"
    t.string "player_or_team_name"
    t.boolean "inactive"
    t.string "player_or_team_id"
    t.string "league_name"
    t.string "tier"
    t.integer "league_points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "league_profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "summoner_name"
    t.string "summoner_id"
    t.string "region"
    t.datetime "riot_updated_at"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description", default: ""
    t.text "champions", default: [], array: true
    t.text "goals", default: [], array: true
    t.text "locales", default: [], array: true
    t.text "roles", default: [], array: true
    t.index ["user_id"], name: "index_league_profiles_on_user_id"
  end

  create_table "league_responses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "swiper_id"
    t.uuid "target_id"
    t.boolean "accepted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["swiper_id"], name: "index_league_responses_on_swiper_id"
    t.index ["target_id"], name: "index_league_responses_on_target_id"
  end

  create_table "lfg_league_profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "league_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_profile_id"], name: "index_lfg_league_profiles_on_league_profile_id"
  end

  create_table "notifications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "signal_id"
    t.string "verb"
    t.integer "status"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.text "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "communication_data", "users"
  add_foreign_key "lfg_league_profiles", "league_profiles"
end
