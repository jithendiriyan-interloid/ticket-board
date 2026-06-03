class AddAssigneeIdToSubtasks < ActiveRecord::Migration[8.1]
  def change
    add_column :subtasks, :assignee_id, :integer
  end
end
