class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :task
  belongs_to :sub_task,  optional: true
  belongs_to :comment, optional: true
end
