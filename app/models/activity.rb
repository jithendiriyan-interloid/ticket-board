class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :task
  belongs_to :sub_task
  belongs_to :comment
end
