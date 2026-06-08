class AddTrackableToActivities < ActiveRecord::Migration[8.1]
  def change
    add_reference :activities, :trackable, polymorphic: true, null: true
  end
end
