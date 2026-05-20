class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :avatar
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable, :trackable
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 },  format: { with: /[!@#$%^&*(),.?":{}|<>]/, message: "must include at least one special character" }, if: -> { password.present? }
 # Soft Delete
 def soft_delete!
   update(deleted_at: Time.current)
 end
 def active_for_authentication?
  super && deleted_at.nil?
 end
 def remove_avatar=(value)
  avatar.purge if value == "1"
 end
  enum :role, {
    member: 0,
    owner: 1,
    admin: 2
  }

  has_many :statuses, dependent: :destroy
  has_many :tasks,    dependent: :destroy

  after_create :seed_default_statuses

  private

  def seed_default_statuses
    defaults = [
      { name: "To do",        color: "#888780", position: 1, is_default: true  },
      { name: "In progress",  color: "#378ADD", position: 2, is_default: false },
      { name: "Done",         color: "#639922", position: 3, is_default: false },
    ]
    defaults.each { |attrs| statuses.create!(attrs) }
  end
end
