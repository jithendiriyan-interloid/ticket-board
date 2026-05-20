class Task < ApplicationRecord
  belongs_to :user
  belongs_to :status, optional: true

  before_save :assign_default_status

  private

  def assign_default_status
    self.status ||= user.statuses.default_status || user.statuses.ordered.first
  end
end