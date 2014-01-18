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

ActiveRecord::Schema.define(:version => 20130930124515) do

  create_table "accounts", :force => true do |t|
    t.integer  "cash"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.integer  "starting_cash",    :default => 0
    t.integer  "debtor_id"
    t.string   "name",             :default => "Unnamed Account"
    t.integer  "split_account_id"
    t.integer  "budget"
  end

  create_table "accounts_users", :id => false, :force => true do |t|
    t.integer "account_id", :null => false
    t.integer "user_id",    :null => false
  end

  add_index "accounts_users", ["account_id", "user_id"], :name => "index_accounts_users_on_account_id_and_user_id", :unique => true

  create_table "data_points", :force => true do |t|
    t.integer  "metric_id"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "data_points", ["metric_id"], :name => "index_data_points_on_metric_id"

  create_table "debtors", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "metrics", :force => true do |t|
    t.integer  "account_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "label"
  end

  add_index "metrics", ["account_id"], :name => "index_metrics_on_account_id"

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 5
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "recurs", :force => true do |t|
    t.string   "name"
    t.datetime "last_recur", :default => '1999-12-31 22:00:00'
    t.datetime "next_recur"
    t.integer  "account_id"
    t.integer  "user_id"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.string   "recur_days"
    t.integer  "value",      :default => 0
  end

  add_index "recurs", ["account_id"], :name => "index_recurs_on_account_id"
  add_index "recurs", ["user_id"], :name => "index_recurs_on_user_id"

  create_table "transactions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.integer  "value"
    t.string   "description"
    t.boolean  "executed"
    t.date     "execution_delay_date"
    t.datetime "datetime_executed"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "account_value",        :default => 0
    t.integer  "recur_id"
    t.boolean  "reversed"
  end

  add_index "transactions", ["user_id"], :name => "index_transactions_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
