class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :task
  has_many :activities
  after_create :log_activity

  private

  def log_activity
    Activity.create!(
      user: user,
      task: task,
      comment: self,
      action: "added a comment"
    )
  end
end