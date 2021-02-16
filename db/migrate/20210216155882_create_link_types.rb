class CreateLinkTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :link_types, comment: 'типы связей, <link_types><type>' do |t|
      t.integer :link_type_id, comment: 'тип ограничения - maybe', null: false
      t.string :name, comment: 'название связи - NAME-PATR', null: false, default: true

      t.index %i[link_type_id], unique: true

      t.timestamps(default: -> { 'CURRENT_TIMESTAMP' })
    end
  end
end
