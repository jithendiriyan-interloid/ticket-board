class AddPositionToTasks < ActiveRecord::Migration[8.1]
  def up
    add_column :tasks, :position, :integer

    execute <<~SQL.squish
      UPDATE tasks
      SET position = ranked.position
      FROM (
        SELECT id, ROW_NUMBER() OVER (
          PARTITION BY project_id, status_id
          ORDER BY created_at, id
        ) AS position
        FROM tasks
      ) ranked
      WHERE tasks.id = ranked.id
    SQL

    change_column_null :tasks, :position, false
    add_index :tasks, [ :project_id, :status_id, :position ]
  end

  def down
    remove_index :tasks, [ :project_id, :status_id, :position ]
    remove_column :tasks, :position
  end
end
