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

ActiveRecord::Schema.define(version: 2020_06_26_084955) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "columns", force: :cascade do |t|
    t.bigint "table_id"
    t.string "name"
    t.string "comment"
    t.boolean "nullable", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "column_type", default: "string"
    t.boolean "is_pk", default: false
    t.boolean "auto_incr", default: false
    t.string "default_value"
    t.index ["table_id"], name: "index_columns_on_table_id"
  end

  create_table "companies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "subdomain"
    t.bigint "owner_id"
  end

  create_table "groups", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "user_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
    t.index ["project_id"], name: "index_groups_on_project_id"
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.bigint "company_id"
    t.bigint "user_id"
    t.string "email", null: false
    t.bigint "invitee_id"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id", "email"], name: "index_invitations_on_company_id_and_email", unique: true
    t.index ["company_id"], name: "index_invitations_on_company_id"
    t.index ["invitee_id"], name: "index_invitations_on_invitee_id"
    t.index ["token"], name: "index_invitations_on_token", unique: true
    t.index ["user_id"], name: "index_invitations_on_user_id"
  end

  create_table "items", primary_key: ["item_code", "item_name"], force: :cascade do |t|
    t.integer "item_code", null: false
    t.string "item_name", limit: 35, null: false
    t.string "purchase_unit", limit: 10
    t.string "sale_unit", limit: 10
    t.decimal "purchase_price", precision: 10, scale: 2
    t.decimal "sale_price", precision: 10, scale: 2
  end

  create_table "items_double_primary_keys", primary_key: ["item_code", "item_name"], force: :cascade do |t|
    t.integer "item_code", null: false
    t.string "item_name", limit: 35, null: false
    t.string "purchase_unit", limit: 10
    t.string "sale_unit", limit: 10
    t.decimal "purchase_price", precision: 10, scale: 2
    t.decimal "sale_price", precision: 10, scale: 2
  end

  create_table "orders", primary_key: "ord_no", id: :integer, default: nil, force: :cascade do |t|
    t.date "ord_date"
    t.integer "item_code"
    t.string "item_name", limit: 35
    t.string "item_grade", limit: 1
    t.decimal "ord_qty"
    t.decimal "ord_amount"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "company_id"
    t.string "adapter", default: "postgresql", null: false, comment: "postgresql,mysql,mssql"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "import_sql_data"
    t.string "share_key"
    t.jsonb "table_csv_data"
    t.jsonb "relation_csv_data"
    t.boolean "auto_draw", default: false
    t.string "bg_color"
    t.string "table_header_color"
    t.string "table_body_color"
    t.string "arrow_color"
    t.boolean "export_foreign_key", default: true
    t.index ["company_id"], name: "index_projects_on_company_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "company_id"
    t.bigint "user_id"
    t.bigint "subscription_id"
    t.date "next_bill_date"
    t.string "paddle_subscription_id"
    t.string "payment_method"
    t.jsonb "event_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_purchases_on_company_id"
    t.index ["subscription_id"], name: "index_purchases_on_subscription_id"
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "table_id"
    t.bigint "relation_table_id"
    t.string "relation_type", default: "many", comment: "many or one"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "column_id"
    t.bigint "relation_column_id"
    t.index ["project_id"], name: "index_relationships_on_project_id"
    t.index ["relation_table_id"], name: "index_relationships_on_relation_table_id"
    t.index ["table_id"], name: "index_relationships_on_table_id"
  end

  create_table "sql_files", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "user_id"
    t.string "filename"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_sql_files_on_project_id"
    t.index ["user_id"], name: "index_sql_files_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "company_id"
    t.bigint "user_id"
    t.string "plan", default: "free"
    t.string "plan_cycle", default: "monthly"
    t.string "state", default: "trial"
    t.datetime "start_at"
    t.jsonb "event_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "next_bill_date"
    t.string "paddle_subscription_id"
    t.index ["company_id"], name: "index_subscriptions_on_company_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "tables", force: :cascade do |t|
    t.bigint "project_id"
    t.string "name"
    t.string "comment"
    t.string "schema", default: "public"
    t.string "table_type", default: "table", comment: "table or view or mv"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_tables_on_group_id"
    t.index ["project_id"], name: "index_tables_on_project_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "password_digest", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "remember_token"
    t.index ["company_id", "email"], name: "index_users_on_company_id_and_email", unique: true
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "columns", "tables"
  add_foreign_key "companies", "users", column: "owner_id"
  add_foreign_key "groups", "projects"
  add_foreign_key "groups", "users"
  add_foreign_key "invitations", "companies"
  add_foreign_key "invitations", "users"
  add_foreign_key "invitations", "users", column: "invitee_id"
  add_foreign_key "orders", "items", column: "item_code", primary_key: "item_code", name: "orders_item_code_fkey"
  add_foreign_key "projects", "companies"
  add_foreign_key "projects", "users"
  add_foreign_key "purchases", "companies"
  add_foreign_key "purchases", "subscriptions"
  add_foreign_key "purchases", "users"
  add_foreign_key "relationships", "columns"
  add_foreign_key "relationships", "columns", column: "relation_column_id"
  add_foreign_key "relationships", "projects"
  add_foreign_key "relationships", "tables"
  add_foreign_key "relationships", "tables", column: "relation_table_id"
  add_foreign_key "sql_files", "projects"
  add_foreign_key "sql_files", "users"
  add_foreign_key "subscriptions", "companies"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "tables", "groups"
  add_foreign_key "tables", "projects"
  add_foreign_key "users", "companies"
end
