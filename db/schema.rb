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

ActiveRecord::Schema.define(:version => 20140328233710) do

  create_table "campaigns", :force => true do |t|
    t.string   "name"
    t.string   "client_name"
    t.string   "status",      :default => "Testing"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "campaigns_emails", :id => false, :force => true do |t|
    t.integer "campaign_id"
    t.integer "email_id"
  end

  add_index "campaigns_emails", ["campaign_id", "email_id"], :name => "index_campaigns_emails_on_campaign_id_and_email_id"

  create_table "campaigns_users", :id => false, :force => true do |t|
    t.integer "campaign_id"
    t.integer "user_id"
  end

  add_index "campaigns_users", ["campaign_id", "user_id"], :name => "index_campaigns_users_on_campaign_id_and_user_id"

  create_table "emails", :force => true do |t|
    t.string   "subject"
    t.text     "recipients"
    t.text     "markup"
    t.string   "campaign_name"
    t.string   "status",                :default => "Testing"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "folder_file_name"
    t.string   "folder_content_type"
    t.integer  "folder_file_size"
    t.datetime "folder_updated_at"
    t.text     "additional_recipients", :default => ""
    t.string   "html_file_name",        :default => ""
  end

  create_table "recipient_lists", :force => true do |t|
    t.string   "name"
    t.text     "list"
    t.boolean  "all_users",  :default => false
    t.boolean  "preferred",  :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "recipient_lists_users", :id => false, :force => true do |t|
    t.integer "recipient_list_id"
    t.integer "user_id"
  end

  add_index "recipient_lists_users", ["recipient_list_id", "user_id"], :name => "index_recipient_lists_users_on_recipient_list_id_and_user_id"

  create_table "transactionals", :force => true do |t|
    t.text     "xml"
    t.text     "shell"
    t.string   "folder_file_name"
    t.string   "folder_content_type"
    t.integer  "folder_file_size"
    t.datetime "folder_updated_at"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "campaign_id"
  end

  create_table "uploads", :force => true do |t|
    t.string   "folder_file_name"
    t.string   "folder_content_type"
    t.integer  "folder_file_size"
    t.datetime "folder_updated_at"
    t.integer  "transactional_id"
    t.integer  "xml_module_id"
    t.integer  "email_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "is_admin",               :default => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "name",                   :default => "",    :null => false
    t.boolean  "confirmed_user",         :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "xsl_modules", :force => true do |t|
    t.text     "xsl"
    t.integer  "order"
    t.integer  "transactional_id"
    t.string   "folder_file_name"
    t.string   "folder_content_type"
    t.integer  "folder_file_size"
    t.datetime "folder_updated_at"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.text     "xslt"
  end

end
