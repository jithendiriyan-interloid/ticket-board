class CardsController < ApplicationController
  before_action :set_board
  before_action :set_card, only: [ :move ]

  def move
    @card.update!(status_id: params.require(:status_id))
    @card.insert_at(params.require(:position).to_i)
    head :ok
  end

  private
  def set_board
    @board = policy_scope(Board).find(params[:board_id])
  end

  def set_card
    @card = @board.cards.find(params[:id])
  end

  def card_params
    params.require(:card).permit(
      :title,
      :description,
      :status_id
    )
  end
end
