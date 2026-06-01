class Workspace < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :memberships
  has_many :users, through: :memberships

  has_many :projects
  has_many :boards

  validates :name, presence: true

  scope :active, -> { where(deleted_at: nil) }
  scope :accessible_to, ->(user) {
    where(owner_id: user.id)
      .or(where(id: Membership.where(user_id: user.id).select(:workspace_id)))
      .distinct
  }

  def soft_delete
    update!(deleted_at: Time.now)
  end
end
