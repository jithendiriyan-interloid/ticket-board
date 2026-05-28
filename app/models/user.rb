class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :avatar
  validate :avatar_size
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable, :trackable
  validates :password, length: { minimum: 6 },  format: { with: /[!@#$%^&*(),.?":{}|<>]/, message: "must include at least one special character" }, if: -> { password.present? }
 # Soft Delete
 def soft_delete!
   update(deleted_at: Time.current)
 end
 def active_for_authentication?
  super && deleted_at.nil?
 end
end

private
def avatar_size
  return unless avatar.attached?
  if avatar.blob.byte_size > 800.kilobytes
    errors.add(:avatar, "Must lest than 800Kb")
  end
end