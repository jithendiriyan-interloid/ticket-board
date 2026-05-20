class CreateBoards < ActiveRecord::Migration[8.1]
  def change
    create_table :boards do |t|
      t.string :name
      t.references :workspace, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.integer :created_by

      t.timestamps
    end
  end
end
