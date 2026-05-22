class ProjectsController < ApplicationController
  before_action :load_workspaces, only: [:new, :create]

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to new_board_path, notice: "Project created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def load_workspaces
    @workspaces = Workspace.order(:name)
  end

  def project_params
    params.require(:project).permit(:name, :description, :workspace_id)
  end
end
