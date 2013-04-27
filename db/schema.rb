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

ActiveRecord::Schema.define(:version => 20130427223035) do

  create_table "article_entities", :force => true do |t|
    t.integer  "article_id"
    t.integer  "entity_id"
    t.float    "sentiment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "article_entities", ["article_id"], :name => "index_article_entities_on_article_id"
  add_index "article_entities", ["entity_id"], :name => "index_article_entities_on_entity_id"

  create_table "articles", :force => true do |t|
    t.string   "source"
    t.string   "original_id"
    t.datetime "date"
    t.string   "url"
    t.string   "title"
    t.text     "content"
    t.hstore   "data"
    t.hstore   "extra_data"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "articles", ["data"], :name => "index_articles_on_data"
  add_index "articles", ["original_id"], :name => "index_articles_on_original_id"

  create_table "entities", :force => true do |t|
    t.string   "name"
    t.string   "entity_type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "entities", ["entity_type"], :name => "index_entities_on_type"
  add_index "entities", ["name"], :name => "index_entities_on_name"

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "users", :force => true do |t|
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
