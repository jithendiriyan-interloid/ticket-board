class Task < ApplicationRecord
  belongs_to :project
  belongs_to :task_type
  belongs_to :status
  belongs_to :label
  belongs_to :story_point

  belongs_to :assignee,
              class_name: 'User',
              foreign_key: "assignee_id",
              optional: true
  acts_as_list scope: [ :project_id, :status_id ]

  has_many :comments
  has_many :activities, dependent: :destroy
  has_many :subtasks, dependent: :destroy

  validates :title, presence: true
  has_many_attached :attachments
end
