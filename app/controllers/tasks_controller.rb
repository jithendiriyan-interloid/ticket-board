class TasksController < ApplicationController
  before_action :load_task_dependencies, only: [ :new, :create, :edit, :update ]
  before_action :set_task, only: [ :edit, :update, :show, :move ]

  def new
    @task = Task.new
    load_board_context
    assign_default_task_values
  end

  def create
    load_board_context
    @task = Task.new(task_params.except(:board_id))
    @task.project = @selected_board.project if @selected_board.present?
    assign_default_task_values

    if invalid_task_assignee?
      render :new, status: :unprocessable_entity
    elsif @task.save
      log_activity("created task #{@task.title}")
      redirect_to boards_path(project_id: @task.project_id), notice: "Task created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    load_existing_task_options
    prepare_subtask_form
  end

  def update
    @task.assign_attributes(task_params.except(:board_id))
    load_existing_task_options
    prepare_subtask_form

    if invalid_task_assignee?
      render :edit, status: :unprocessable_entity
    elsif @task.save
      log_activity("updated task #{@task.title}")
      redirect_to boards_path(project_id: @task.project_id), notice: "Task updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @task = accessible_tasks
            .includes(:status, :project, :task_type, :story_point, :label, :assignee, subtasks: [ :status, :story_point, :assignee ])
            .find(params[:id])
    @activities = @task.activities.includes(:user).order(created_at: :desc)
    @available_statuses = statuses_for_project(@task.project)
    @story_points = StoryPoint.order(:value)
    @users = users_for_workspace(@task.project.workspace)
  end

  def move
    @task.update!(status_id: params.require(:status_id))
    @task.insert_at(params.require(:position).to_i)
    log_activity("moved task #{@task.title} to #{@task.status.name}")

    head :ok
  end

  private

  def set_task
    @task = accessible_tasks.find(params[:id])
  end

  def accessible_tasks
    Task.joins(:project).merge(policy_scope(Project))
  end

  # ── Board / context helpers
  def load_board_context
    @selected_board    = find_selected_board
    @available_statuses = statuses_for(@selected_board)
    @users             = users_for(@selected_board)
  end

  def find_selected_board
    board_id = params[:board_id] || params.dig(:task, :board_id)
    return if board_id.blank?
    @boards.find { |b| b.id == board_id.to_i }
  end

  # ── Status / user helpers
  def statuses_for(board)
    return Status.order(:name) if board.blank?
    statuses = board.board_sections.includes(:status).map(&:status).compact.uniq
    statuses.any? ? statuses : Status.order(:name)
  end

  def statuses_for_project(project)
    statuses = policy_scope(Board)
               .where(project: project)
               .includes(board_sections: :status)
               .flat_map { |b| b.board_sections.map(&:status) }
               .compact.uniq
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

  # ── Task form helpers
  def load_task_dependencies
    @boards       = policy_scope(Board).includes(:project).order(:name)
    @labels       = Label.order(:name)
    @task_types   = TaskType.order(:name)
    @story_points = StoryPoint.order(:value)
    @users        = []
  end

  def load_existing_task_options
    @available_statuses = ([ @task.status ] + statuses_for_project(@task.project)).compact.uniq
    @users = users_for_workspace(@task.project.workspace)
  end

  def prepare_subtask_form
    @subtask = @task.subtasks.build(status: @task.status, story_point: @task.story_point)
  end

  def assign_default_task_values
    @task.status_id      ||= @available_statuses.first&.id
    @task.label_id       ||= @labels.first&.id
    @task.task_type_id   ||= @task_types.first&.id
    @task.story_point_id ||= @story_points.first&.id
  end

  def invalid_task_assignee?
    return false if @task.assignee_id.blank?
    return false if @users.exists?(id: @task.assignee_id)
    @task.errors.add(:assignee_id, "must belong to the board workspace")
    true
  end

  # ── Activity
 def log_activity(action)
  activity = Activity.create!(
    user: current_user,
    action: action,
    task_id: @task.id
  )

  Turbo::StreamsChannel.broadcast_prepend_to(
    "activities_#{@task.id}",
    target: "activity_feed",
    partial: "activities/activity",
    locals: { activity: activity }
  )
end

  # ── Params
  def task_params
    params.require(:task).permit(
      :board_id, :title, :description, :status_id,
      :label_id, :task_type_id, :story_point_id,
      :assignee_id, :start_date, :end_date,
      attachments: []
    )
  end
end