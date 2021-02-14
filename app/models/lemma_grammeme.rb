# create_table :opencorpa_lgrammemes, comment: "Openсorpa, граммемы леммы, <g>", force: :cascade do |t|
#   t.string :grammeme_type
#   t.bigint :grammeme_id, comment: "грамема"
#   t.string :v, null: false, comment: "текст словоформы"
#   t.datetime :created_at, precision: 6, default: -> { :CURRENT_TIMESTAMP }, null: false
#   t.datetime :updated_at, precision: 6, default: -> { :CURRENT_TIMESTAMP }, null: false
#   t.index [:grammeme_id, :v], name: :index_opencorpa_lgrammemes_on_grammeme_id_and_v, unique: true
#   t.index [:grammeme_type, :grammeme_id], name: :index_opencorpa_lgrammemes_on_grammeme_type_and_grammeme_id
# end

class LemmaGrammeme < ApplicationRecord
  belongs_to :lemma_grammemes, class_name: 'LemmaGrammeme', polymorphic: true, optional: true
end
