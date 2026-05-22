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
end
