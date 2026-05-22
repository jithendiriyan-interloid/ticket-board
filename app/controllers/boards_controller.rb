class BoardsController < ApplicationController
  before_action :load_board_dependencies, only: [:new, :create]

  def index
    @user = current_user
    @statuses = Status.order(:id)
    @boards = Board.includes(project: :tasks).order(:id)
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

  def load_board_dependencies
    @workspaces = Workspace.order(:name)
    @projects = Project.includes(:workspace).order(:name)
  end

  def board_params
    params.require(:board).permit(:name, :workspace_id, :project_id)
  end
end
