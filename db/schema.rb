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

ActiveRecord::Schema.define(version: 2021_02_16_155802) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "grammemes", comment: "Openсorpa, граммемы, <grammeme>", force: :cascade do |t|
    t.string "name", null: false, comment: "название грамемы - neut"
    t.string "parent", null: false, comment: "родительская грамема - GNdr"
    t.string "alias", null: false, comment: "краткое обозначение - ср"
    t.string "description", null: false, comment: "описание - средний род"
    t.datetime "created_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["name"], name: "index_grammemes_on_name", unique: true
  end

  create_table "lemma_forms", comment: "Openсorpa, словоформы лемм, <f>", force: :cascade do |t|
    t.bigint "lemma_id", comment: "код леммы"
    t.string "text", comment: "текст словоформы <t>"
    t.datetime "created_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["lemma_id", "text"], name: "index_lemma_forms_on_lemma_id_and_text"
    t.index ["lemma_id"], name: "index_lemma_forms_on_lemma_id"
  end

  create_table "lemma_grammemes", comment: "Openсorpa, граммемы леммы, <g>", force: :cascade do |t|
    t.string "kind_type"
    t.bigint "kind_id", comment: "тип грамемы: text, form"
    t.bigint "grammeme_id", null: false, comment: "ссылка на грамему"
    t.datetime "created_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["grammeme_id"], name: "index_lemma_grammemes_on_grammeme_id"
    t.index ["kind_type", "kind_id", "grammeme_id"], name: "index_lemma_grammemes_on_kind_type_and_kind_id_and_grammeme_id"
    t.index ["kind_type", "kind_id"], name: "index_lemma_grammemes_on_kind_type_and_kind_id"
  end

  create_table "lemma_texts", comment: "Openсorpa, тексты лемм, <l>", force: :cascade do |t|
    t.bigint "lemma_id", comment: "код леммы"
    t.string "text", comment: "текст словоформы <t>"
    t.datetime "created_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["lemma_id", "text"], name: "index_lemma_texts_on_lemma_id_and_text", unique: true
    t.index ["lemma_id"], name: "index_lemma_texts_on_lemma_id"
  end

  create_table "lemmas", comment: "Openсorpa леммы", force: :cascade do |t|
    t.bigint "lemma_id", null: false, comment: "айди леммы"
    t.integer "rev", null: false, comment: "ревизия описания леммы"
    t.datetime "created_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["id", "rev"], name: "index_lemmas_on_id_and_rev", unique: true
  end

end
