# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_08_181216) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lists", force: :cascade do |t|
    t.string "source"
    t.string "title"
    t.string "inner_title"
    t.string "inner_id"
    t.string "inner_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "key"
    t.string "slug"
    t.index ["key"], name: "index_lists_on_key", unique: true
    t.index ["slug"], name: "index_lists_on_slug", unique: true
  end

  create_table "tasks", force: :cascade do |t|
    t.text "text"
    t.bigint "list_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.index ["list_id"], name: "index_tasks_on_list_id"
  end

  add_foreign_key "tasks", "lists"
end
