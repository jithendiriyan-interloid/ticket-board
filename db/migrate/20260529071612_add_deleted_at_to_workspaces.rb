class AddDeletedAtToWorkspaces < ActiveRecord::Migration[8.1]
  def change
    add_column :workspaces, :deleted_at, :datetime
  end
end
