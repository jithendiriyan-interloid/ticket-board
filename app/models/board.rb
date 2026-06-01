class Board < ApplicationRecord
  belongs_to :workspace
  belongs_to :project
  has_many :board_sections
  has_many :cards, dependent: :destroy

  validates :name, presence: true
  validate :project_belongs_to_workspace

  scope :accessible_to, ->(user) {
    joins(:workspace).merge(Workspace.accessible_to(user))
  }

  private

  def project_belongs_to_workspace
    return if project.blank? || workspace.blank?
    return if project.workspace_id == workspace_id

    errors.add(:project_id, "must belong to the selected workspace")
  end
end
