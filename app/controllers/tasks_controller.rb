class TasksController < ApplicationController
  before_action :load_task_dependencies, only: [:new, :create]

  def new
    @task = Task.new
    @selected_board = find_selected_board
    @available_statuses = statuses_for(@selected_board)
    assign_default_task_values
  end

  def create
    @selected_board = find_selected_board
    @available_statuses = statuses_for(@selected_board)
    @task = Task.new(task_params.except(:board_id))
    @task.project = @selected_board.project if @selected_board.present?
    assign_default_task_values

    if @task.save
      redirect_to boards_path, notice: "Task created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def load_task_dependencies
    @boards = Board.includes(:project).order(:name)
    @labels = Label.order(:name)
    @task_types = TaskType.order(:name)
    @story_points = StoryPoint.order(:value)
    @users = User.order(:first_name, :email)
  end

  def find_selected_board
    board_id = params[:board_id] || params.dig(:task, :board_id)
    return if board_id.blank?

    @boards.find { |board| board.id == board_id.to_i }
  end

  def statuses_for(board)
    return [] if board.blank?

    board.board_sections.includes(:status).map(&:status).uniq.presence || Status.order(:name)
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
      :assignee,
      :start_date,
      :end_date
    )
  end
end
