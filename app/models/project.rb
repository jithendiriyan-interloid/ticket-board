class Project < ApplicationRecord
  belongs_to :workspace
  has_many :tasks, dependent: :destroy
  has_many :boards

  validates :name, presence: true

  scope :accessible_to, ->(user) {
    joins(:workspace).merge(Workspace.accessible_to(user))
  }
end
