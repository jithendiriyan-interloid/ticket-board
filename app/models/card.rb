class Card < ApplicationRecord
  belongs_to :board
  belongs_to :status

  acts_as_list scope: [ :board_id, :status_id ]
end
