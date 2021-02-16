# create_table :opencorpa_lemmas, comment: "Openсorpa леммы", force: :cascade do |t|
#   t.bigint :lemma_id, null: false, comment: "айди леммы"
#   t.integer :rev, null: false, comment: "ревизия описания леммы"
#   t.datetime :created_at, precision: 6, default: -> { :CURRENT_TIMESTAMP }, null: false
#   t.datetime :updated_at, precision: 6, default: -> { :CURRENT_TIMESTAMP }, null: false
#   t.index [:id, :rev], name: :index_opencorpa_lemmas_on_id_and_rev, unique: true
# end

class Grammeme < ApplicationRecord
end
