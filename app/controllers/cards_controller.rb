class CardsController < ApplicationController
  before_action :set_board

  def create
    @card = @board.cards.new(card_params)
    if @card.save
      redirect_to boards_path(project_id: @board.project_id),
        notice: "Card created successfully"
    else
      redirect_to boards_path(project_id: @board.project_id),
        alert: @card.errors.full_messages.to_sentence
    end
  end

  private
  def set_board
    @board = policy_scope(Board).find(params[:board_id])
  end

  def card_params
    params.require(:card).permit(
      :title,
      :description,
      :status_id
    )
  end
end
