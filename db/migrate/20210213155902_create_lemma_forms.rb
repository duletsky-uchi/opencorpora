class CreateLemmaForms < ActiveRecord::Migration[6.0]
  def change
    create_table :lemma_forms, comment: 'словоформы лемм, <f>' do |t|
      t.references :lemma, comment: 'код леммы'
      t.string :text, comment: 'текст словоформы <t>'

      # t.timestamps(default: -> { 'CURRENT_TIMESTAMP' })
      t.timestamps(null: true)

      t.index %i[lemma_id text] # неуникально, несколько форм могут совпадать
    end
    change_column_default :lemma_forms, :created_at, -> { 'now()' }
    change_column_default :lemma_forms, :updated_at, -> { 'now()' }
  end
end
