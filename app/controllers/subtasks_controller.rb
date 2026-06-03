class SubtasksController < ApplicationController
  before_action :set_task
  before_action :set_subtask, only: [ :edit, :update, :destroy ]
  before_action :load_subtask_options, only: [ :new, :create, :edit, :update ]

  def new
    @subtask = @task.subtasks.build
    assign_default_subtask_values
  end

  def create
    @subtask = @task.subtasks.build(subtask_params)
    assign_default_subtask_values

    if invalid_subtask_assignee?
      render :new, status: :unprocessable_entity
    elsif @subtask.save
      redirect_to task_redirect_path, notice: "Subtask added"
    else
      render :new, status: :unprocessable_entity
    end
  end
  def show
    @task = Task.find(params[:task_id])
    @subtask = @task.subtasks.find(params[:id])
  end
  def edit
  end

  def update
    @subtask.assign_attributes(subtask_params)

    if invalid_subtask_assignee?
      render :edit, status: :unprocessable_entity
    elsif @subtask.save
      redirect_to task_redirect_path, notice: "Subtask updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @subtask.destroy

    redirect_to task_redirect_path, notice: "Subtask deleted"
  end

  private

  def set_task
    @task = accessible_tasks.find(params[:task_id])
  end

  def set_subtask
    @subtask = @task.subtasks.find(params[:id])
  end

  def accessible_tasks
    Task.joins(:project).merge(policy_scope(Project))
  end

  def statuses_for_project(project)
    statuses = policy_scope(Board)
               .where(project: project)
               .includes(board_sections: :status)
               .flat_map { |board| board.board_sections.map(&:status) }
               .compact
               .uniq

    statuses.any? ? statuses : Status.order(:name)
  end

  def users_for_workspace(workspace)
    User.where(id: workspace.owner_id)
        .or(User.where(id: Membership.where(workspace_id: workspace.id).select(:user_id)))
        .distinct
        .order(:first_name, :email)
  end

  def invalid_subtask_assignee?
    return false if @subtask.assignee_id.blank?
    return false if @users.exists?(id: @subtask.assignee_id)

    @subtask.errors.add(:assignee_id, "must belong to the task workspace")
    true
  end

  def load_subtask_options
    @available_statuses = statuses_for_project(@task.project)
    @story_points = StoryPoint.order(:value)
    @users = users_for_workspace(@task.project.workspace)
  end

  def assign_default_subtask_values
    @subtask.status_id ||= @task.status_id || @available_statuses.first&.id
    @subtask.story_point_id ||= @task.story_point_id || @story_points.first&.id
  end

  def render_edit?
    params[:return_to] == "edit"
  end

  def task_redirect_path
    render_edit? ? edit_task_path(@task) : task_path(@task)
  end

  def subtask_params
    params.require(:subtask).permit(
      :title,
      :description,
      :status_id,
      :story_point_id,
      :assignee_id,
      :start_date,
      :end_date,
      attachments: [],
    )
  end
end
