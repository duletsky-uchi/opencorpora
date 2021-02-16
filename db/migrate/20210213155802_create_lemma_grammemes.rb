class CreateLemmaGrammemes < ActiveRecord::Migration[6.0]
  def change
    create_table :lemma_grammemes, comment: 'Openсorpa, граммемы леммы, <g>' do |t|
      t.references :kind, polymorphic: true, index: true, comment: 'тип грамемы: text, form'
      t.references :grammeme, comment: 'ссылка на грамему', null: false

      t.index %i[kind_type kind_id grammeme_id]

      t.timestamps(default: -> { 'CURRENT_TIMESTAMP' })
    end
  end
end
