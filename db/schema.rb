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

ActiveRecord::Schema.define(version: 2023_05_03_000110) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "assist_requests", force: :cascade do |t|
    t.bigint "resource_request_item_id", null: false
    t.bigint "organization_id", null: false
    t.bigint "event_id", null: false
    t.string "code"
    t.boolean "arrived"
    t.datetime "arrival_date"
    t.string "vehicle_registration"
    t.integer "number_of_people"
    t.string "status"
    t.string "assigned_to"
    t.datetime "demobilization_date"
    t.boolean "demobilized"
    t.string "demobilizing_person"
    t.string "comments"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_assist_requests_on_event_id"
    t.index ["organization_id"], name: "index_assist_requests_on_organization_id"
    t.index ["resource_request_item_id"], name: "index_assist_requests_on_resource_request_item_id"
  end

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

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
    t.datetime "event_end"
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
    t.string "kind"
    t.boolean "closed"
    t.decimal "longitude"
    t.decimal "latitude"
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
    t.integer "quantity", default: 0
    t.integer "quantity_used", default: 0
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["resource_id", "organization_id"], name: "user_permission_index", unique: true
  end

  create_table "resource_request_items", force: :cascade do |t|
    t.bigint "resource_request_id", null: false
    t.bigint "resource_id", null: false
    t.integer "quantity", default: 0
    t.integer "quantity_used", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["resource_id"], name: "index_resource_request_items_on_resource_id"
    t.index ["resource_request_id"], name: "index_resource_request_items_on_resource_request_id"
  end

  create_table "resource_requests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.bigint "organization_id"
    t.string "status"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_resource_requests_on_event_id"
    t.index ["organization_id"], name: "index_resource_requests_on_organization_id"
    t.index ["user_id"], name: "index_resource_requests_on_user_id"
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
    t.string "place_of_registration"
    t.datetime "date"
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_victims_on_event_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "assist_requests", "events"
  add_foreign_key "assist_requests", "organizations"
  add_foreign_key "assist_requests", "resource_request_items"
  add_foreign_key "event_actions", "events"
  add_foreign_key "organizations", "organizations", column: "parent_organization_id"
  add_foreign_key "resource_per_organizations", "organizations"
  add_foreign_key "resource_per_organizations", "resources"
  add_foreign_key "resource_request_items", "resource_requests"
  add_foreign_key "resource_request_items", "resources"
  add_foreign_key "resource_requests", "events"
  add_foreign_key "resource_requests", "organizations"
  add_foreign_key "resource_requests", "users"
  add_foreign_key "user_permissions", "organizations"
  add_foreign_key "user_permissions", "users"
  add_foreign_key "victims", "events"
end
