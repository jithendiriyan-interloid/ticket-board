class Task < ApplicationRecord
  belongs_to :project
  belongs_to :task_type
  belongs_to :status
  belongs_to :label
  belongs_to :story_point

  belongs_to :assignee,
              class_name: 'User',
              foreign_key: :assignee_id
  has_many :comments
  has_many :activities
  has_many :subtask

  validates :title, presence: true
end
