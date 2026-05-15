class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :avatar
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable, :trackable
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 },  format: { with: /[!@#$%^&*(),.?":{}|<>]/, message: "must include at least one special character" }, if: -> { password.present? }
end
