class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.references :project, null: false, foreign_key: true
      t.references :task_type, null: false, foreign_key: true
      t.references :status, null: false, foreign_key: true
      t.references :label, null: false, foreign_key: true
      t.integer :assignee
      t.references :story_point, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
