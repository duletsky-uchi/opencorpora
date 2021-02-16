class CreateLinkTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :link_types, comment: 'типы связей, <link_types><type>' do |t|
      t.string :name, comment: 'название связи - NAME-PATR', null: false, default: true

      t.timestamps(default: -> { 'CURRENT_TIMESTAMP' })
    end
  end
end
