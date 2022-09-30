# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_09_20_012112) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_actions", force: :cascade do |t|
    t.text "description"
    t.datetime "date"
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_event_actions_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "form_start"
    t.datetime "event_start"
    t.text "location"
    t.text "event_nature"
    t.text "threats"
    t.text "affected_area"
    t.text "isolation"
    t.text "objectives"
    t.text "strategy"
    t.text "tactics"
    t.text "pc_location"
    t.text "e_location"
    t.text "entry_route"
    t.text "egress_route"
    t.text "security_message"
    t.text "communication_channels"
    t.string "commander"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "parent_organization_id"
    t.boolean "allow_sub_organizations"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parent_organization_id"], name: "index_organizations_on_parent_organization_id"
  end

  create_table "resource_per_organizations", force: :cascade do |t|
    t.bigint "resource_id", null: false
    t.bigint "organization_id", null: false
    t.decimal "quantity"
    t.decimal "quantity_available"
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["resource_id", "organization_id"], name: "user_permission_index", unique: true
  end

  create_table "resources", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "kind"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_permissions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "organization_id", null: false
    t.string "role"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_user_permissions_on_organization_id"
    t.index ["user_id", "organization_id"], name: "user_organization_index", unique: true
    t.index ["user_id"], name: "index_user_permissions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "ci"
    t.string "address"
    t.string "address_two"
    t.string "city"
    t.date "birthday"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "victims", force: :cascade do |t|
    t.string "name"
    t.string "sex"
    t.integer "age"
    t.string "classification"
    t.boolean "treated_on_site"
    t.string "place_of_transfer"
    t.string "transferred_by"
    t.datetime "date"
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_victims_on_event_id"
  end

  add_foreign_key "event_actions", "events"
  add_foreign_key "organizations", "organizations", column: "parent_organization_id"
  add_foreign_key "resource_per_organizations", "organizations"
  add_foreign_key "resource_per_organizations", "resources"
  add_foreign_key "user_permissions", "organizations"
  add_foreign_key "user_permissions", "users"
  add_foreign_key "victims", "events"
end
