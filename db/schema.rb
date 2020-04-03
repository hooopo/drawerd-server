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

ActiveRecord::Schema.define(version: 2020_04_03_212238) do

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
    t.index ["table_id"], name: "index_columns_on_table_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "uuid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uuid"], name: "index_companies_on_uuid", unique: true
  end

  create_table "groups", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "user_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_groups_on_project_id"
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "company_id"
    t.string "adapter", default: "postgresql", null: false, comment: "postgresql,mysql,mssql"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "import_sql_data"
    t.index ["company_id"], name: "index_projects_on_company_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
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

  create_table "users", comment: "This is my table.", force: :cascade do |t|
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "columns", "tables"
  add_foreign_key "groups", "projects"
  add_foreign_key "groups", "users"
  add_foreign_key "projects", "companies"
  add_foreign_key "projects", "users"
  add_foreign_key "relationships", "columns"
  add_foreign_key "relationships", "columns", column: "relation_column_id"
  add_foreign_key "relationships", "projects"
  add_foreign_key "relationships", "tables"
  add_foreign_key "relationships", "tables", column: "relation_table_id"
  add_foreign_key "sql_files", "projects"
  add_foreign_key "sql_files", "users"
  add_foreign_key "tables", "groups"
  add_foreign_key "tables", "projects"
  add_foreign_key "users", "companies"
end
