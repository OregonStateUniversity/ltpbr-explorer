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

ActiveRecord::Schema[7.1].define(version: 2024_04_10_004019) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_enum :user_role, [
    "public",
    "admin",
  ], force: :cascade

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "affiliations", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "organization_id", null: false
    t.string "role"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["organization_id"], name: "index_affiliations_on_organization_id"
    t.index ["project_id", "organization_id"], name: "index_affiliations_on_project_id_and_organization_id", unique: true
    t.index ["project_id"], name: "index_affiliations_on_project_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "contact"
    t.string "website"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "affiliations_count", default: 0, null: false
  end

  create_table "project_photos", force: :cascade do |t|
    t.string "description"
    t.date "date"
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_photos_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "stream_name", null: false
    t.date "implementation_date", null: false
    t.text "narrative", null: false
    t.integer "length", null: false
    t.string "primary_contact", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.geography "lonlat", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}, null: false
    t.bigint "author_id", null: false
    t.integer "number_of_structures", null: false
    t.text "structure_description", null: false
    t.string "name", null: false
    t.string "watershed", null: false
    t.string "url"
    t.bigint "state_id"
    t.integer "affiliations_count", default: 0, null: false
    t.integer "project_photos_count", default: 0, null: false
    t.index ["author_id"], name: "index_projects_on_author_id"
    t.index ["state_id"], name: "index_projects_on_state_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name", null: false
    t.string "iso_code", null: false
    t.geometry "geom", limit: {:srid=>0, :type=>"multi_polygon"}, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "projects_count", default: 0, null: false
    t.index ["geom"], name: "index_states_on_geom", using: :gist
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "username", null: false
    t.string "affiliation", null: false
    t.string "name", null: false
    t.enum "role", default: "public", enum_type: "user_role"
    t.integer "projects_count", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "affiliations", "organizations"
  add_foreign_key "affiliations", "projects"
  add_foreign_key "project_photos", "projects"
  add_foreign_key "projects", "states"
  add_foreign_key "projects", "users", column: "author_id"
end
