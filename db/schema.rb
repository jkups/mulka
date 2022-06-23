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

ActiveRecord::Schema.define(version: 2022_06_21_073743) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "buyers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "full_name", null: false
    t.string "preferred_name"
    t.string "mobile_number"
    t.string "address"
    t.string "suburb"
    t.string "city"
    t.string "country"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_buyers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_buyers_on_reset_password_token", unique: true
  end

  create_table "expression_of_interests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "offer_id", null: false
    t.uuid "buyer_id", null: false
    t.integer "units", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buyer_id"], name: "index_expression_of_interests_on_buyer_id"
    t.index ["offer_id"], name: "index_expression_of_interests_on_offer_id"
  end

  create_table "external_references", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "referenceable_source"
    t.string "referenceable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "good_job_processes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "state"
  end

  create_table "good_jobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "queue_name"
    t.integer "priority"
    t.jsonb "serialized_params"
    t.datetime "scheduled_at"
    t.datetime "performed_at"
    t.datetime "finished_at"
    t.text "error"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "active_job_id"
    t.text "concurrency_key"
    t.text "cron_key"
    t.uuid "retried_good_job_id"
    t.datetime "cron_at"
    t.index ["active_job_id", "created_at"], name: "index_good_jobs_on_active_job_id_and_created_at"
    t.index ["active_job_id"], name: "index_good_jobs_on_active_job_id"
    t.index ["concurrency_key"], name: "index_good_jobs_on_concurrency_key_when_unfinished", where: "(finished_at IS NULL)"
    t.index ["cron_key", "created_at"], name: "index_good_jobs_on_cron_key_and_created_at"
    t.index ["cron_key", "cron_at"], name: "index_good_jobs_on_cron_key_and_cron_at", unique: true
    t.index ["finished_at"], name: "index_good_jobs_jobs_on_finished_at", where: "((retried_good_job_id IS NULL) AND (finished_at IS NOT NULL))"
    t.index ["queue_name", "scheduled_at"], name: "index_good_jobs_on_queue_name_and_scheduled_at", where: "(finished_at IS NULL)"
    t.index ["scheduled_at"], name: "index_good_jobs_on_scheduled_at", where: "(finished_at IS NULL)"
  end

  create_table "offers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "property_id", null: false
    t.integer "total_units", null: false
    t.integer "minimum_units", null: false
    t.integer "available_units", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["property_id"], name: "index_offers_on_property_id"
  end

  create_table "organization_contacts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "mobile_number", null: false
    t.uuid "organization_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_organization_contacts_on_organization_id"
  end

  create_table "organizations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.string "suburb", null: false
    t.string "city", null: false
    t.string "country", null: false
    t.string "registration_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "portfolios", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "number", null: false
    t.boolean "active", null: false
    t.uuid "buyer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buyer_id"], name: "index_portfolios_on_buyer_id"
  end

  create_table "properties", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "pid", null: false
    t.string "name", null: false
    t.string "address", null: false
    t.string "suburb", null: false
    t.string "city", null: false
    t.string "country", null: false
    t.text "description", null: false
    t.string "image", null: false
    t.boolean "occupied", null: false
    t.string "category", null: false
    t.integer "classification", null: false
    t.uuid "organization_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_properties_on_organization_id"
  end

  create_table "property_expenses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "settled_property_id", null: false
    t.datetime "date", precision: 6, null: false
    t.string "description", null: false
    t.decimal "amount", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["settled_property_id"], name: "index_property_expenses_on_settled_property_id"
  end

  create_table "property_features", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "property_id", null: false
    t.integer "bed", null: false
    t.integer "bath", null: false
    t.integer "parking", null: false
    t.integer "floor_size", null: false
    t.integer "plot_size", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["property_id"], name: "index_property_features_on_property_id"
  end

  create_table "property_managers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "full_name", null: false
    t.string "mobile", null: false
    t.string "email", null: false
    t.string "company_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "property_rents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "settled_property_id", null: false
    t.datetime "date", precision: 6, null: false
    t.string "description", null: false
    t.decimal "amount", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["settled_property_id"], name: "index_property_rents_on_settled_property_id"
  end

  create_table "property_valuations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "settled_property_id", null: false
    t.datetime "date", precision: 6, null: false
    t.decimal "estimate", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["settled_property_id"], name: "index_property_valuations_on_settled_property_id"
  end

  create_table "sellers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "full_name", null: false
    t.uuid "organization_id", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_sellers_on_email", unique: true
    t.index ["organization_id"], name: "index_sellers_on_organization_id"
    t.index ["reset_password_token"], name: "index_sellers_on_reset_password_token", unique: true
  end

  create_table "settled_properties", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "property_id", null: false
    t.uuid "property_manager_id", null: false
    t.integer "status", null: false
    t.decimal "monthly_rent", null: false
    t.datetime "lease_start_on", precision: 6, null: false
    t.datetime "lease_end_on", precision: 6, null: false
    t.string "lease_term", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["property_id"], name: "index_settled_properties_on_property_id"
    t.index ["property_manager_id"], name: "index_settled_properties_on_property_manager_id"
  end

  create_table "tranzactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "units", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.decimal "fee", precision: 10, scale: 2, null: false
    t.uuid "offer_id", null: false
    t.uuid "portfolio_id", null: false
    t.uuid "external_reference_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["external_reference_id"], name: "index_tranzactions_on_external_reference_id"
    t.index ["offer_id"], name: "index_tranzactions_on_offer_id"
    t.index ["portfolio_id"], name: "index_tranzactions_on_portfolio_id"
  end

  add_foreign_key "expression_of_interests", "buyers"
  add_foreign_key "expression_of_interests", "offers"
  add_foreign_key "offers", "properties"
  add_foreign_key "organization_contacts", "organizations"
  add_foreign_key "portfolios", "buyers"
  add_foreign_key "properties", "organizations"
  add_foreign_key "property_expenses", "settled_properties"
  add_foreign_key "property_features", "properties"
  add_foreign_key "property_rents", "settled_properties"
  add_foreign_key "property_valuations", "settled_properties"
  add_foreign_key "settled_properties", "properties"
  add_foreign_key "settled_properties", "property_managers"
  add_foreign_key "tranzactions", "external_references"
  add_foreign_key "tranzactions", "offers"
  add_foreign_key "tranzactions", "portfolios"
end
