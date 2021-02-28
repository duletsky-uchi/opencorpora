class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.references :lemma_from, null: false, foreign_key: { to_table: :lemmas }
      t.references :lemma_to, null: false, foreign_key: { to_table: :lemmas }
      t.references :type, null: false, foreign_key: { to_table: :link_types }

      # t.timestamps
      t.timestamps(null: true)
    end
  end
end
