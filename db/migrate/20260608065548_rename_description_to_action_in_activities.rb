class RenameDescriptionToActionInActivities < ActiveRecord::Migration[8.1]
  def change
    rename_column :activities, :description, :action
  end
end
