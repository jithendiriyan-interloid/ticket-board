class TasksController < ApplicationController
  before_action :load_task_dependencies, only: [:new, :create]

  def new
    @task = Task.new
    @selected_board = find_selected_board
    @available_statuses = statuses_for(@selected_board)
    @users = users_for(@selected_board)
    assign_default_task_values
  end

  def create
    @selected_board = find_selected_board
    @available_statuses = statuses_for(@selected_board)
    @users = users_for(@selected_board)
    @task = Task.new(task_params.except(:board_id))
    @task.project = @selected_board.project if @selected_board.present?
    assign_default_task_values
    if invalid_task_assignee?
      render :new, status: :unprocessable_entity
    elsif @task.save
      redirect_to boards_path(project_id: @task.project_id), notice: "Task created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @task = accessible_tasks.find(params[:id])
  end

  def update
    @task = accessible_tasks.find(params[:id])
    @task.assign_attributes(task_params.except(:board_id))
    @users = users_for_workspace(@task.project.workspace)
    if invalid_task_assignee?
      render :edit, status: :unprocessable_entity
    elsif @task.save
      redirect_to boards_path(project_id: @task.project_id), notice: "Task updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def load_task_dependencies
    @boards = policy_scope(Board).includes(:project).order(:name)
    @labels = Label.order(:name)
    @task_types = TaskType.order(:name)
    @story_points = StoryPoint.order(:value)
    @users = []
  end

  def find_selected_board
    board_id = params[:board_id] || params.dig(:task, :board_id)
    return if board_id.blank?
    @boards.find { |board| board.id == board_id.to_i }
  end

  def statuses_for(board)
    return Status.order(:name) if board.blank?

    statuses = board.board_sections
                    .includes(:status)
                    .map(&:status)
                    .compact
                    .uniq

    statuses.any? ? statuses : Status.order(:name)
  end

  def users_for(board)
    return User.none if board.blank?

    users_for_workspace(board.workspace)
  end

  def users_for_workspace(workspace)
    User.where(id: workspace.owner_id)
        .or(User.where(id: Membership.where(workspace_id: workspace.id).select(:user_id)))
        .distinct
        .order(:first_name, :email)
  end

  def accessible_tasks
    Task.joins(:project).merge(policy_scope(Project))
  end

  def invalid_task_assignee?
    return false if @task.assignee_id.blank?
    return false if @users.exists?(id: @task.assignee_id)

    @task.errors.add(:assignee_id, "must belong to the board workspace")
    true
  end

  def assign_default_task_values
    @task.status_id ||= @available_statuses.first&.id
    @task.label_id ||= @labels.first&.id
    @task.task_type_id ||= @task_types.first&.id
    @task.story_point_id ||= @story_points.first&.id
  end

  def task_params
    params.require(:task).permit(
      :board_id,
      :title,
      :description,
      :status_id,
      :label_id,
      :task_type_id,
      :story_point_id,
      :assignee_id,
      :start_date,
      :end_date
    )
  end
end
