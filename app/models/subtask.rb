class Subtask < ApplicationRecord
  belongs_to :task
  belongs_to :status
  belongs_to :story_point
  belongs_to :assignee,
             class_name: 'User',
             foreign_key: :assignee_id

  has_many :activities
end
