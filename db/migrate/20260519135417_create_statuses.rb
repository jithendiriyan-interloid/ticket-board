class CreateStatuses < ActiveRecord::Migration[8.1]
def change
    create_table :statuses do |t|
      t.string  :name,       null: false
      t.string  :color,      null: false, default: "#888780"
      t.integer :position,   null: false, default: 0
      t.boolean :is_default, null: false, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :statuses, [:user_id, :name], unique: true
  end
end
