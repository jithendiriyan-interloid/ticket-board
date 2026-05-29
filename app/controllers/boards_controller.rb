class BoardsController < ApplicationController
  before_action :load_board_dependencies, only: [:new, :create, :edit, :update]
  before_action :set_board, only: [:edit, :update]

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

  def edit
  end

  def update
    if @board.update(board_params)
      redirect_to boards_path, notice: "Board updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def set_board
    @board = Board.find(params[:id])
  end

  def load_board_dependencies
    @workspaces = Workspace.order(:name)
    @projects = Project.includes(:workspace).order(:name)
  end

  def board_params
    params.require(:board).permit(:name, :workspace_id, :project_id)
  end
end