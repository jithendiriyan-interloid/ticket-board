class RemoveUnusedColumnsFromActivities < ActiveRecord::Migration[8.1]
  def change
    remove_column :activities, :subtask_id
    remove_column :activities, :comment_id
    remove_column :activities, :trackable_type
    remove_column :activities, :trackable_id
  end
end
