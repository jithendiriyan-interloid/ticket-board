class AddLabelData < ActiveRecord::Migration[8.1]
  def up
      [
        { name: "Bug"         },
        { name: "Design"      },
        { name: "Feature"     },
        { name: "Improvement" },
        { name: "Testing"     },
        { name: "Documentation" }
      ].each do |label|
        Label.find_or_create_by!(name: label[:name])
      end
  end
end
