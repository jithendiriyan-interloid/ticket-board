class Workspace < ApplicationRecord
  has_many :memberships
  has_many :user, through: :memberships

  has_many :project
  has_many :boards

  validates :name, presence: true
end
