class LemmaGrammemes < ActiveRecord::Migration[6.0]
  def change
    create_table :lemma_grammemes, comment: 'Openсorpa, граммемы леммы, <g>' do |t|
      t.references :grammeme, polymorphic: true, comment: 'грамема'
      t.string :v, comment: 'текст словоформы', null: false

      t.index %i[grammeme_id v], unique: true

      t.timestamps(default: -> { 'CURRENT_TIMESTAMP' })
    end

  end
end
