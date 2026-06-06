class MakeActivityReferencesOptional < ActiveRecord::Migration[8.1]
  def change
    change_column_null :activities, :subtask_id, true
    change_column_null :activities, :comment_id, true
    add_column :activities, :action, :string
  end
end
