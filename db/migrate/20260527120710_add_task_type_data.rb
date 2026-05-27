class AddTaskTypeData < ActiveRecord::Migration[8.1]
  def up
    [
      { name: "Low"      },
      { name: "Medium" },
      { name: "High"     },
      { name: "Critical"   }
    ].each do |task_type|
        TaskType.find_or_create_by!(name: task_type[:name])
    end
  end
end
