class Status < ApplicationRecord
  has_many :tasks
  has_many :subtasks
  has_many :board_sections
  has_many :cards
end