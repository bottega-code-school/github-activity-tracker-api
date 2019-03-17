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

ActiveRecord::Schema.define(version: 2019_03_17_025335) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "user_id"
    t.string "login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar_url"
    t.string "bio"
    t.integer "public_repos"
    t.integer "public_gists"
    t.integer "followers"
    t.integer "following"
    t.datetime "member_since"
    t.string "city"
    t.string "state"
    t.string "postal"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "account_id"
    t.string "repo_name"
    t.string "repo_url"
    t.datetime "date"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "commit_count"
    t.text "github_event_id"
    t.index ["account_id"], name: "index_events_on_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "events", "accounts"
end
