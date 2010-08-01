# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100319020538) do

  create_table "decision_types", :force => true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "text_id"
  end

  create_table "decisions", :force => true do |t|
    t.integer  "project_id"
    t.integer  "creator_user_id"
    t.string   "summary"
    t.string   "result"
    t.date     "expiration_date"
    t.integer  "decidable_id"
    t.string   "decidable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "decisions_tasks", :id => false, :force => true do |t|
    t.integer  "decision_id"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "decisions_user_collections", :id => false, :force => true do |t|
    t.integer  "decision_id"
    t.integer  "user_collection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expand_share_pool_decisions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "task_id"
  end

  create_table "general_multiple_choice_decisions", :force => true do |t|
    t.string   "question"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "general_yes_no_decisions", :force => true do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "multiple_choice_options", :force => true do |t|
    t.integer  "general_multiple_choice_decision_id"
    t.string   "option"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_decision_handler", :force => true do |t|
    t.integer  "decision_id"
    t.text     "expression"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.integer  "total_shares"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "summary"
  end

  create_table "shareholders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "num_shares"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_shares", :force => true do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.integer  "num_shares"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_statuses", :force => true do |t|
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "days_to_complete"
    t.integer  "project_id"
    t.integer  "requester_user_id"
    t.integer  "performer_user_id"
    t.integer  "num_shares"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "task_status_id"
    t.string   "offered_or_wanted"
  end

  create_table "text_change_decisions", :force => true do |t|
    t.string   "target_field"
    t.text     "target_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_collections", :force => true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_collections_users", :id => false, :force => true do |t|
    t.integer  "user_collection_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", :force => true do |t|
    t.text     "choice"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "decision_id"
    t.integer  "shareholder_id"
    t.integer  "num_shares"
  end

  create_table "who_should_do_something_decisions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "task_id"
  end

end
