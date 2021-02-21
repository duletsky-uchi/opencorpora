class CreateLemmas < ActiveRecord::Migration[6.0]
  def change
    create_table :lemmas, comment: 'Openсorpa леммы' do |t|
      t.bigint :lemma_id, comment: 'айди леммы', null: false
      t.integer :rev, comment: 'ревизия описания леммы', null: false

      t.timestamps(default: -> { 'CURRENT_TIMESTAMP' })

      t.index %i[id rev], unique: true
      t.index %i[lemma_id rev], unique: true
    end
  end
end
