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

ActiveRecord::Schema.define(version: 20210608161014) do

  create_table "activities", force: :cascade do |t|
    t.string "label"
    t.string "category"
    t.decimal "duration", precision: 10, scale: 2
    t.date "date"
    t.integer "project_id"
    t.integer "user_id"
    t.decimal "fee", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_activities_on_project_id"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "assignments", force: :cascade do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.decimal "default_fee", precision: 10, scale: 2
    t.index ["project_id"], name: "index_assignments_on_project_id"
    t.index ["user_id"], name: "index_assignments_on_user_id"
  end

  create_table "contact_addresses", force: :cascade do |t|
    t.string "pobox"
    t.string "street"
    t.string "streetno"
    t.string "zip"
    t.string "city"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contact_roles", force: :cascade do |t|
    t.string "label"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string "prefix"
    t.string "first_name"
    t.string "last_name"
    t.string "suffix"
    t.string "phone"
    t.string "email"
    t.date "birthday"
    t.string "activity"
    t.boolean "company"
    t.string "company_id"
    t.text "notes"
    t.integer "contact_address_id"
    t.integer "contact_role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_address_id"], name: "index_contacts_on_contact_address_id"
    t.index ["contact_role_id"], name: "index_contacts_on_contact_role_id"
  end

  create_table "contacts_projects", id: false, force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "contact_id", null: false
  end

  create_table "deadlines", force: :cascade do |t|
    t.string "label"
    t.string "category"
    t.date "date"
    t.integer "project_id"
    t.integer "assignee_id"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignee_id"], name: "index_deadlines_on_assignee_id"
    t.index ["project_id"], name: "index_deadlines_on_project_id"
  end

  create_table "project_categories", force: :cascade do |t|
    t.string "label"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "label"
    t.text "description"
    t.string "status"
    t.string "reference"
    t.integer "owner_id"
    t.integer "project_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_projects_on_owner_id"
    t.index ["project_category_id"], name: "index_projects_on_project_category_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.string "label"
    t.integer "access_level"
    t.decimal "default_fee", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "login"
    t.string "password_digest"
    t.string "avatar"
    t.integer "contact_id"
    t.integer "user_role_id"
    t.string "preferred_lang"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_users_on_contact_id"
    t.index ["user_role_id"], name: "index_users_on_user_role_id"
  end

end
