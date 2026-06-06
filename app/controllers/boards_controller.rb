class BoardsController < ApplicationController
  before_action :load_board_dependencies, only: [ :new, :create, :edit, :update ]

  def index
    @statuses = Status.order(:id)
    @project = policy_scope(Project).find(params[:project_id]) if params[:project_id].present?
    @boards = policy_scope(Board)
                .includes(:cards, project: :workspace)
                .order(:id)
    @boards = @boards.where(project_id: @project.id) if @project.present?
    @boards_by_project = @boards.group_by(&:project)
    project_ids = @boards_by_project.keys.map(&:id)
    @tasks_by_project_status = Task
                               .where(project_id: project_ids)
                               .includes(:assignee, :label, :task_type, :story_point)
                               .order(:status_id, :position, :id)
                               .group_by { |task| [ task.project_id, task.status_id ] }
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
    @board = policy_scope(Board).find(params[:id])
    authorize @board
  end

  def update
    @board = policy_scope(Board).find(params[:id])
    @board.assign_attributes(board_params)
    authorize @board
    if @board.save
      redirect_to boards_path(project_id: @board.project_id), notice: "Board updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def load_board_dependencies
    @workspaces = policy_scope(Workspace).active.order(:name)
    @projects = policy_scope(Project).includes(:workspace).order(:name)
  end

  def board_params
    params.require(:board).permit(:name, :workspace_id, :project_id)
  end
end
