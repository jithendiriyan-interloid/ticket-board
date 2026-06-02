class BoardSection < ApplicationRecord
  belongs_to :board
  belongs_to :status
end
