class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable, :trackable
  validates :email, presence: true, uniqueness: true
  validates :password, format: {with: /[!@#$%^&*(),.?":{}|<>]/, message: "must include at least one special character"}, length: { minimum:6 } 
end
