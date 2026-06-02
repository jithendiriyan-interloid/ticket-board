class CreateStoryPoints < ActiveRecord::Migration[8.1]
  def change
    create_table :story_points do |t|
      t.integer :value
      t.string :label

      t.timestamps
    end
  end
end
