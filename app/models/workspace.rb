class Workspace < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :memberships
  has_many :user, through: :memberships

  has_many :project
  has_many :boards

  validates :name, presence: true
end
