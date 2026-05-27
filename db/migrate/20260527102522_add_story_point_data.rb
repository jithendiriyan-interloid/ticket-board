class AddStoryPointData < ActiveRecord::Migration[8.1]
  def up
    [
      { value: 1,  label: "XS"  },
      { value: 2,  label: "S"   },
      { value: 3,  label: "M"   },
      { value: 5,  label: "L"   },
      { value: 8,  label: "XL"  },
      { value: 13,  label: "XXL" },
      { value: 21,  label: "EPIC" }
    ].each do |sp|
      StoryPoint.find_or_create_by!(value: sp[:value]) do |record|
        record.label = sp[:label]
      end
    end
  end
end
