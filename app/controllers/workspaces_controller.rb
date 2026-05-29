class WorkspacesController < ApplicationController
  before_action :set_workspace, only: [:show, :edit, :update, :destroy]

  def index
    @workspaces = policy_scope(Workspace).active.order(:name)
  end

  def show
    authorize @workspace
  end

  def new
    @workspace = Workspace.new
    authorize @workspace
  end

  def create
    @workspace = Workspace.new(workspace_params)
    @workspace.owner_id = current_user.id
    authorize @workspace
    if @workspace.save
      redirect_to new_project_path(workspace_id: @workspace.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @workspace
  end

  def update
    authorize @workspace
    if @workspace.update(workspace_params)
      redirect_to workspaces_path, notice: "Workspace updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @workspace
    @workspace.soft_delete
    redirect_to workspaces_path, notice: "Workspace deleted successfully."
  end

  private
  def set_workspace
    @workspace = Workspace.find(params[:id])
  end

  def workspace_params
    params.require(:workspace).permit(:name, :description)
  end
end