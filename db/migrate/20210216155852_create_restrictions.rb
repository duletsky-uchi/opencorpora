class CreateRestrictions < ActiveRecord::Migration[6.0]
  def change
    create_table :restrictions, comment: 'Ограничения на совместное употребление лемм, <rest>' do |t|
      t.string :typ, comment: 'тип ограничения - maybe', null: false
      t.boolean :auto, comment: 'авто - 0', null: false, default: true
      t.string :left_type, comment: 'тип леммы слева - lemma', null: false
      t.string :left_grammeme_id, comment: 'грамема слева - NOUN', null: false
      t.string :right_type, comment: 'тип леммы справа - lemma', null: false
      t.string :right_grammeme_id, comment: 'грамема справа - ANim', null: false

      t.index %i[left_grammeme_id right_grammeme_id]

      t.timestamps(default: -> { 'CURRENT_TIMESTAMP' })
    end
  end
end
