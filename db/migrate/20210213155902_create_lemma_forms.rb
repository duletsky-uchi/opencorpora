class Lemmaforms < ActiveRecord::Migration[6.0]
  def change
    create_table :lemma_forms, comment: 'Openсorpa, словоформы лемм, <f>' do |t|
      t.references :lemma, comment: 'код леммы'
      t.string :text, comment: 'текст словоформы <t>'

      t.timestamps(default: -> { 'CURRENT_TIMESTAMP' })

      t.index %i[lemma_id text], unique: true
    end
  end
end
