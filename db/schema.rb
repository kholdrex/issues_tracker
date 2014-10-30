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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141030140305) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "issue_statuses", force: true do |t|
    t.string   "name"
    t.boolean  "default_value"
    t.boolean  "closed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "issues", force: true do |t|
    t.string   "subject"
    t.text     "description"
    t.integer  "issue_status_id"
    t.integer  "priority_id"
    t.integer  "assigned_to_id"
    t.integer  "author_id"
    t.integer  "parent_id"
    t.date     "start_date"
    t.date     "due_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.integer  "tracker_id"
  end

  create_table "list_values", force: true do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.boolean  "default_value", default: false
  end

  create_table "members", force: true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members_roles", id: false, force: true do |t|
    t.integer "member_id", null: false
    t.integer "role_id",   null: false
  end

  add_index "members_roles", ["member_id", "role_id"], name: "index_members_roles_on_member_id_and_role_id", using: :btree
  add_index "members_roles", ["role_id", "member_id"], name: "index_members_roles_on_role_id_and_member_id", using: :btree

  create_table "permissions", force: true do |t|
    t.string   "name"
    t.string   "subject_class"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions_roles", id: false, force: true do |t|
    t.integer "permission_id", null: false
    t.integer "role_id",       null: false
  end

  add_index "permissions_roles", ["permission_id", "role_id"], name: "index_permissions_roles_on_permission_id_and_role_id", using: :btree
  add_index "permissions_roles", ["role_id", "permission_id"], name: "index_permissions_roles_on_role_id_and_permission_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects_trackers", id: false, force: true do |t|
    t.integer "project_id", null: false
    t.integer "tracker_id", null: false
  end

  add_index "projects_trackers", ["project_id", "tracker_id"], name: "index_projects_trackers_on_project_id_and_tracker_id", using: :btree
  add_index "projects_trackers", ["tracker_id", "project_id"], name: "index_projects_trackers_on_tracker_id_and_project_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trackers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin",               default: false
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
