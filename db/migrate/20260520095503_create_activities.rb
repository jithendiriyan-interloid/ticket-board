class CreateActivities < ActiveRecord::Migration[8.1]
  def change
    create_table :activities do |t|
      t.references :user, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true
      t.references :subtask, null: false, foreign_key: true
      t.references :comment, null: false, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
