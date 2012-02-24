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

ActiveRecord::Schema.define(:version => 20120223151059) do

  create_table "admins", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "cms_blocks", :force => true do |t|
    t.integer  "page_id",    :null => false
    t.string   "identifier", :null => false
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_blocks", ["page_id", "identifier"], :name => "index_cms_blocks_on_page_id_and_identifier"

  create_table "cms_categories", :force => true do |t|
    t.integer "site_id",          :null => false
    t.string  "label",            :null => false
    t.string  "categorized_type", :null => false
  end

  add_index "cms_categories", ["site_id", "categorized_type", "label"], :name => "index_cms_categories_on_site_id_and_categorized_type_and_label", :unique => true

  create_table "cms_categorizations", :force => true do |t|
    t.integer "category_id",      :null => false
    t.string  "categorized_type", :null => false
    t.integer "categorized_id",   :null => false
  end

  add_index "cms_categorizations", ["category_id", "categorized_type", "categorized_id"], :name => "index_cms_categorizations_on_cat_id_and_catd_type_and_catd_id", :unique => true

  create_table "cms_files", :force => true do |t|
    t.integer  "site_id",                                          :null => false
    t.integer  "block_id"
    t.string   "label",                                            :null => false
    t.string   "file_file_name",                                   :null => false
    t.string   "file_content_type",                                :null => false
    t.integer  "file_file_size",                                   :null => false
    t.string   "description",       :limit => 2048
    t.integer  "position",                          :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_files", ["site_id", "block_id"], :name => "index_cms_files_on_site_id_and_block_id"
  add_index "cms_files", ["site_id", "file_file_name"], :name => "index_cms_files_on_site_id_and_file_file_name"
  add_index "cms_files", ["site_id", "label"], :name => "index_cms_files_on_site_id_and_label"
  add_index "cms_files", ["site_id", "position"], :name => "index_cms_files_on_site_id_and_position"

  create_table "cms_layouts", :force => true do |t|
    t.integer  "site_id",                       :null => false
    t.integer  "parent_id"
    t.string   "app_layout"
    t.string   "label",                         :null => false
    t.string   "identifier",                    :null => false
    t.text     "content"
    t.text     "css"
    t.text     "js"
    t.integer  "position",   :default => 0,     :null => false
    t.boolean  "is_shared",  :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_layouts", ["parent_id", "position"], :name => "index_cms_layouts_on_parent_id_and_position"
  add_index "cms_layouts", ["site_id", "identifier"], :name => "index_cms_layouts_on_site_id_and_identifier", :unique => true

  create_table "cms_pages", :force => true do |t|
    t.integer  "site_id",                           :null => false
    t.integer  "layout_id"
    t.integer  "parent_id"
    t.integer  "target_page_id"
    t.string   "label",                             :null => false
    t.string   "slug"
    t.string   "full_path",                         :null => false
    t.text     "content"
    t.integer  "position",       :default => 0,     :null => false
    t.integer  "children_count", :default => 0,     :null => false
    t.boolean  "is_published",   :default => true,  :null => false
    t.boolean  "is_shared",      :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_pages", ["parent_id", "position"], :name => "index_cms_pages_on_parent_id_and_position"
  add_index "cms_pages", ["site_id", "full_path"], :name => "index_cms_pages_on_site_id_and_full_path"

  create_table "cms_revisions", :force => true do |t|
    t.string   "record_type", :null => false
    t.integer  "record_id",   :null => false
    t.text     "data"
    t.datetime "created_at"
  end

  add_index "cms_revisions", ["record_type", "record_id", "created_at"], :name => "index_cms_revisions_on_record_type_and_record_id_and_created_at"

  create_table "cms_sites", :force => true do |t|
    t.string  "label",                          :null => false
    t.string  "identifier",                     :null => false
    t.string  "hostname",                       :null => false
    t.string  "path"
    t.string  "locale",      :default => "en",  :null => false
    t.boolean "is_mirrored", :default => false, :null => false
  end

  add_index "cms_sites", ["hostname"], :name => "index_cms_sites_on_hostname"
  add_index "cms_sites", ["is_mirrored"], :name => "index_cms_sites_on_is_mirrored"

  create_table "cms_snippets", :force => true do |t|
    t.integer  "site_id",                       :null => false
    t.string   "label",                         :null => false
    t.string   "identifier",                    :null => false
    t.text     "content"
    t.integer  "position",   :default => 0,     :null => false
    t.boolean  "is_shared",  :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_snippets", ["site_id", "identifier"], :name => "index_cms_snippets_on_site_id_and_identifier", :unique => true
  add_index "cms_snippets", ["site_id", "position"], :name => "index_cms_snippets_on_site_id_and_position"

  create_table "comments", :force => true do |t|
    t.text     "comment"
    t.string   "author"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "email"
    t.integer  "tendency"
    t.integer  "reply_to"
  end

  create_table "commissions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commissions_initiatives", :id => false, :force => true do |t|
    t.integer "commission_id"
    t.integer "initiative_id"
  end

  create_table "commissions_representatives", :id => false, :force => true do |t|
    t.integer "commission_id"
    t.integer "representative_id"
  end

  create_table "initiatives", :force => true do |t|
    t.datetime "presented_at"
    t.text     "description"
    t.text     "title"
    t.string   "presented_by"
    t.text     "additional_resources"
    t.string   "additional_resources_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.integer  "official_vote_up",          :default => 0
    t.integer  "official_vote_down",        :default => 0
    t.integer  "representative_id"
    t.boolean  "main"
    t.integer  "political_party_id"
    t.datetime "voted_at"
    t.integer  "official_vote_abstentions"
    t.integer  "comments_count",            :default => 0
    t.string   "number"
    t.integer  "position"
  end

  create_table "initiatives_topics", :id => false, :force => true do |t|
    t.integer "initiative_id"
    t.integer "topic_id"
  end

  create_table "news", :force => true do |t|
    t.text     "title"
    t.text     "url"
    t.integer  "representative_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "official_votes", :force => true do |t|
    t.integer  "political_party_id"
    t.integer  "votes"
    t.integer  "initiative_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "political_parties", :force => true do |t|
    t.string   "name"
    t.string   "logo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "provinces", :force => true do |t|
    t.string   "name"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "representation_actions", :force => true do |t|
    t.text     "name"
    t.text     "url"
    t.integer  "representative_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "representatives", :force => true do |t|
    t.string   "first_name"
    t.string   "position"
    t.integer  "region_id"
    t.integer  "province_id"
    t.string   "avatar"
    t.text     "biography"
    t.string   "birthday"
    t.string   "twitter"
    t.string   "facebook"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "political_party_id"
    t.string   "district"
    t.string   "phone"
    t.string   "email"
    t.string   "substitute"
    t.string   "election_type"
    t.string   "old_commissions"
    t.integer  "comments_count",     :default => 0
    t.string   "circumscription"
    t.string   "last_name"
    t.integer  "number_votes"
  end

  create_table "representatives_topics", :id => false, :force => true do |t|
    t.integer "representative_id"
    t.integer "topic_id"
  end

  create_table "resources", :force => true do |t|
    t.text     "name"
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "resoursable_type"
    t.integer  "resoursable_id"
  end

  create_table "topics", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", :force => true do |t|
    t.integer  "vote"
    t.integer  "initiative_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
