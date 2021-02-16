class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.references :lemma_from, null: false, foreign_key: {to_table: :lemmas}
      t.references :lemma_to, null: false, foreign_key: {to_table: :lemmas}
      t.string :typ

      t.timestamps
    end
  end
end