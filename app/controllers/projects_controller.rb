class ProjectsController < ApplicationController
  before_action :set_project, only: [:edit, :update, :destroy]
  before_action :load_workspaces, only: [:new, :create, :edit, :update]

  def index
    @projects = Project.includes(:workspace).order(:name)
  end

  def new
    @project = Project.new
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
    authorize @project
    if @project.update(project_params)
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
    @project = Project.find(params[:id])
  end

  def load_workspaces
    @workspaces = Workspace.order(:name)
  end

  def project_params
    params.require(:project).permit(:name, :description, :workspace_id)
  end
end