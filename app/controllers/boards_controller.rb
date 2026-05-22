class BoardsController < ApplicationController
  def index
    @user = current_user
    @statuses = Status.includes(:cards)
    @boards = Board.all
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)

    if @board.save
      redirect_to boards_path, notice: "Board created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def board_params
    params.require(:board).permit(:name)
  end
end