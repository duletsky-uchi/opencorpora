class CreateGrammemes < ActiveRecord::Migration[6.0]
  def change
    create_table :grammemes, comment: 'Openсorpa, граммемы, <grammeme>' do |t|
      t.string :name, comment: 'название грамемы - neut', null: false
      t.string :parent, comment: 'родительская грамема - GNdr', null: false
      t.string :alias, comment: 'краткое обозначение - ср', null: false
      t.string :description, comment: 'описание - средний род', null: false

      t.index %i[name], unique: true

      # t.timestamps(default: -> { 'CURRENT_TIMESTAMP' })
      t.timestamps(null: true)
    end
  end
end
