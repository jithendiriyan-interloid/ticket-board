class WorkspacesController < ApplicationController
  def index
    @workspaces = policy_scope(Workspace)
  end

  def show
    @workspace = Workspace.find(params[:id])

    authorize @workspace
  end
  def new
    @workspace = Workspace.new
  end
  def create
    @workspace = Workspace.new(workspace_params)
    @workspace.owner_id = current_user.id
    if @workspace.save
     redirect_to new_project_path(workspace_id: @workspace.id)
    else
      render :new, status: :unprocessable_entity
    end
  end
  private
  def workspace_params
    params.require(:workspace).permit(:name, :description)
  end
end
