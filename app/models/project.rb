class Project < ApplicationRecord
  belongs_to :workspace
  has_many :tasks
  has_many :boards

  validates :name, presence: true
end
