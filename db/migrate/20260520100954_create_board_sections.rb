class CreateBoardSections < ActiveRecord::Migration[8.1]
  def change
    create_table :board_sections do |t|
      t.references :board, null: false, foreign_key: true
      t.references :status, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
