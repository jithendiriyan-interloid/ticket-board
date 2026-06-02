class Board < ApplicationRecord
  belongs_to :workspace
  belongs_to :project
  has_many :board_sections
end
