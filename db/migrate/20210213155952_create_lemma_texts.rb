class CreateLemmaTexts < ActiveRecord::Migration[6.0]
  def change
    create_table :lemma_texts, comment: 'Openсorpa, тексты лемм, <l>' do |t|
      t.references :lemma, comment: 'код леммы'
      t.string :text, comment: 'текст словоформы <t>'

      # t.timestamps(default: -> { 'CURRENT_TIMESTAMP' })
      t.timestamps(null: true)
      # t.timestamps

      t.index %i[lemma_id text], unique: true
    end
    change_column_default :lemma_texts, :created_at, -> { 'now()' }
    change_column_default :lemma_texts, :updated_at, -> { 'now()' }
  end
end
