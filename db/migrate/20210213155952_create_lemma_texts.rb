class CreateLtexts < ActiveRecord::Migration[6.0]
  def change
    create_table :ltexts, comment: 'Openсorpa, тексты лемм, <l>' do |t|
      t.references :lemma, comment: 'код леммы'
      t.string :text, comment: 'текст словоформы <t>'

      t.timestamps(default: -> { 'CURRENT_TIMESTAMP' })

      t.index %i[lemma_id text], unique: true
    end
  end
end
