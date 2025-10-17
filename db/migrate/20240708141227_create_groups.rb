class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.integer :genre_id
      t.string :name
      t.text :introduction
      t.references :owner, null: false, foreign_key: { to_table: :customers }
      t.timestamps
    end
  end
end
