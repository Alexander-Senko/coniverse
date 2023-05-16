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

ActiveRecord::Schema[7.1].define(version: 2024_02_04_202626) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adjustable_schema_relationship_roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_adjustable_schema_relationship_roles_on_name", unique: true
  end

  create_table "adjustable_schema_relationships", force: :cascade do |t|
    t.string "source_type"
    t.uuid "source_id"
    t.string "target_type"
    t.uuid "target_id"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_adjustable_schema_relationships_on_role_id"
    t.index ["source_id", "target_id", "role_id"], name: "index_adjustable_schema_relationships_uniqueness", unique: true
    t.index ["source_type", "source_id"], name: "index_adjustable_schema_relationships_on_source"
    t.index ["target_type", "target_id"], name: "index_adjustable_schema_relationships_on_target"
  end

  add_foreign_key "adjustable_schema_relationships", "adjustable_schema_relationship_roles", column: "role_id"
end
