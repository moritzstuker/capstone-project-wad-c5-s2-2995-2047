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

ActiveRecord::Schema.define(version: 20210613055616) do

  create_table "activities", force: :cascade do |t|
    t.string "label"
    t.string "category"
    t.date "date"
    t.decimal "duration", precision: 10, scale: 2
    t.decimal "fee", precision: 10, scale: 2
    t.integer "project_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_activities_on_project_id"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "contact_roles", force: :cascade do |t|
    t.string "label"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "activity"
    t.string "phone"
    t.string "email"
    t.string "pobox"
    t.string "street"
    t.string "city"
    t.string "country"
    t.integer "category"
    t.text "notes"
    t.string "import_uid"
    t.integer "contact_role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_role_id"], name: "index_contacts_on_contact_role_id"
  end

  create_table "contacts_projects", id: false, force: :cascade do |t|
    t.integer "contact_id", null: false
    t.integer "project_id", null: false
  end

  create_table "deadlines", force: :cascade do |t|
    t.string "label"
    t.string "category"
    t.date "date"
    t.datetime "completed_at"
    t.integer "project_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_deadlines_on_project_id"
    t.index ["user_id"], name: "index_deadlines_on_user_id"
  end

  create_table "project_categories", force: :cascade do |t|
    t.string "label"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "label"
    t.string "reference"
    t.integer "status"
    t.text "description"
    t.integer "owner_id"
    t.integer "project_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_projects_on_owner_id"
    t.index ["project_category_id"], name: "index_projects_on_project_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "login"
    t.string "name"
    t.string "password_digest"
    t.string "avatar"
    t.string "email"
    t.string "locale"
    t.integer "role"
    t.decimal "default_fee", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
