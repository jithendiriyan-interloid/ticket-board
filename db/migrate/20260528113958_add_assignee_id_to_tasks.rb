class AddAssigneeIdToTasks < ActiveRecord::Migration[8.1]
  def change
    add_column :tasks, :assignee_id, :integer
  end
end
