class Status < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :nullify   # or :restrict_with_error

  validates :name,  presence: true, uniqueness: { scope: :user_id, case_sensitive: false }
  validates :color, presence: true, format: { with: /\A#[0-9A-Fa-f]{6}\z/, message: "must be a valid hex color" }
  validates :position, numericality: { only_integer: true, greater_than: 0 }

  before_create :set_position
  before_save   :enforce_single_default

  scope :ordered, -> { order(:position) }
  scope :default_status, -> { find_by(is_default: true) }

  private

  def set_position
    self.position = (user.statuses.maximum(:position) || 0) + 1
  end

  def enforce_single_default
    if is_default? && is_default_changed?
      user.statuses.where.not(id: id).update_all(is_default: false)
    end
  end
end