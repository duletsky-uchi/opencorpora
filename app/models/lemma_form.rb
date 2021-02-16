# create_table :opencorpa_lforms, comment: "Openсorpa, словоформы лемм, <f>", force: :cascade do |t|
#   t.bigint :opencorpa_lemma_id, comment: "код леммы"
#   t.string :text, comment: "текст словоформы <t>"
#   t.datetime :created_at, precision: 6, default: -> { :CURRENT_TIMESTAMP }, null: false
#   t.datetime :updated_at, precision: 6, default: -> { :CURRENT_TIMESTAMP }, null: false
#   t.index [:opencorpa_lemma_id, :text], name: :index_opencorpa_lforms_on_opencorpa_lemma_id_and_text, unique: true
#   t.index [:opencorpa_lemma_id], name: :index_opencorpa_lforms_on_opencorpa_lemma_id
# end

class LemmaForm < ApplicationRecord
  belongs_to :lemma
  has_many :grammemes, as: :kind, class_name: 'LemmaForm', source: LemmaGrammeme
end
