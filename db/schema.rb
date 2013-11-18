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

ActiveRecord::Schema.define(:version => 20131117233819) do

  create_table "divisions", :force => true do |t|
    t.integer  "league_id"
    t.string   "name"
    t.integer  "num_teams"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "game_length"
    t.integer  "num_locations"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "divisions", ["league_id"], :name => "index_divisions_on_league_id"

  create_table "invitations", :force => true do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "invitations", ["team_id"], :name => "index_invitations_on_team_id"
  add_index "invitations", ["user_id"], :name => "index_invitations_on_user_id"

  create_table "leagues", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "captain_email"
    t.string   "name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "division_id"
  end

  add_index "teams", ["division_id"], :name => "index_teams_on_division_id", :unique => true

  create_table "teams_users", :id => false, :force => true do |t|
    t.integer "team_id"
    t.integer "user_id"
  end

  add_index "teams_users", ["team_id", "user_id"], :name => "index_teams_users_on_team_id_and_user_id"
  add_index "teams_users", ["user_id"], :name => "index_teams_users_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "remember_token"
    t.string   "password_digest"
    t.boolean  "admin"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "password_confirmation"
  end

end
