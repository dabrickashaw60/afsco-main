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

ActiveRecord::Schema[7.1].define(version: 2024_08_02_154233) do
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
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "appointments", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
    t.integer "job_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "assignments", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.bigint "crew_id", null: false
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crew_id", "date"], name: "index_assignments_on_crew_id_and_date", unique: true
    t.index ["job_id"], name: "index_assignments_on_job_id"
  end

  create_table "crews", force: :cascade do |t|
    t.string "name"
    t.integer "foreman_id"
    t.integer "laborer1_id"
    t.integer "laborer2_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string "job_number"
    t.bigint "salesman_id", null: false
    t.string "customer_name"
    t.text "address"
    t.string "customer_phone"
    t.string "customer_email"
    t.decimal "total_amount"
    t.string "type_of_work"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "city"
    t.string "state"
    t.string "country"
    t.date "install_date"
    t.boolean "installed", default: false
    t.date "install_start_date"
    t.date "install_end_date"
    t.string "crew"
    t.integer "crew_id"
    t.string "job_category"
    t.bigint "appointment_id"
    t.index ["appointment_id"], name: "index_jobs_on_appointment_id"
    t.index ["salesman_id"], name: "index_jobs_on_salesman_id"
  end

  create_table "salesmen", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_salesmen_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: ""
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "role"
    t.string "salesman_type"
    t.index ["email"], name: "index_users_on_email", unique: true, where: "(email IS NOT NULL)"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "appointments", "users"
  add_foreign_key "assignments", "crews"
  add_foreign_key "assignments", "jobs"
  add_foreign_key "crews", "users", column: "foreman_id"
  add_foreign_key "crews", "users", column: "laborer1_id"
  add_foreign_key "crews", "users", column: "laborer2_id"
  add_foreign_key "jobs", "appointments"
  add_foreign_key "jobs", "users", column: "salesman_id"
  add_foreign_key "salesmen", "users"
end
