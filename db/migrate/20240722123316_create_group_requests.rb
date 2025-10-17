class CreateGroupRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :group_requests do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.integer :is_status, default: 0, null: false

      t.timestamps
    end
  end
end
