class BoardsController < ApplicationController
  before_action :load_board_dependencies, only: [:new, :create, :edit, :update]
  before_action :set_board, only: [:edit, :update]

  def index
    @user = current_user
    @statuses = Status.order(:id)
    @project = policy_scope(Project).find(params[:project_id]) if params[:project_id].present?
    @boards = policy_scope(Board)
                .includes(project: [:workspace, { tasks: [:label, :task_type] }])
                .order(:id)
    @boards = @boards.where(project_id: @project.id) if @project.present?
    @boards_by_project = @boards.group_by(&:project)
  end

  def new
    @project = policy_scope(Project).find(params[:project_id]) if params[:project_id].present?
    @board = Board.new(project: @project, workspace: @project&.workspace)
  end

  def create
    @board = Board.new(board_params)
    authorize @board
    if @board.save
      redirect_to boards_path(project_id: @board.project_id), notice: "Board created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @board
  end

  def update
    @board.assign_attributes(board_params)
    authorize @board
    if @board.save
      redirect_to boards_path(project_id: @board.project_id), notice: "Board updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def set_board
    @board = policy_scope(Board).find(params[:id])
  end

  def load_board_dependencies
    @workspaces = policy_scope(Workspace).active.order(:name)
    @projects = policy_scope(Project).includes(:workspace).order(:name)
  end

  def board_params
    params.require(:board).permit(:name, :workspace_id, :project_id)
  end
end
