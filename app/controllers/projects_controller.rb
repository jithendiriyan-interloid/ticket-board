class ProjectsController < ApplicationController
  before_action :set_project, only: [:edit, :update, :destroy]
  before_action :load_workspaces, only: [:new, :create, :edit, :update]

  def index
    @workspace = policy_scope(Workspace).active.find(params[:workspace_id]) if params[:workspace_id].present?
    @projects = policy_scope(Project).includes(:workspace).order(:name)
    @projects = @projects.where(workspace_id: @workspace.id) if @workspace.present?
  end

  def new
    @workspace = policy_scope(Workspace).active.find(params[:workspace_id]) if params[:workspace_id].present?
    @project = Project.new(workspace: @workspace)
  end

  def create
    @project = Project.new(project_params)
    authorize @project
    if @project.save
      redirect_to projects_path, notice: "Project created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @project
  end

  def update
    @project.assign_attributes(project_params)
    authorize @project
    if @project.save
      redirect_to projects_path, notice: "Project updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @project
    @project.destroy
    redirect_to projects_path, notice: "Project deleted."
  end

  private
  def set_project
    @project = policy_scope(Project).find(params[:id])
  end

  def load_workspaces
    @workspaces = policy_scope(Workspace).active.order(:name)
  end

  def project_params
    params.require(:project).permit(:name, :description, :workspace_id)
  end
end
