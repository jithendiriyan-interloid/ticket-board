class StatusesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_status, only: [:edit, :update, :destroy]

  def index
    @statuses = policy_scope(Status).ordered
  end

  def new
    @status = current_user.statuses.build
    authorize @status
  end

  def create
    @status = current_user.statuses.build(status_params)
    authorize @status

    if @status.save
      redirect_to statuses_path, notice: "Status created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @status
  end

  def update
    authorize @status
    if @status.update(status_params)
      redirect_to statuses_path, notice: "Status updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @status
    fallback = current_user.statuses.find_by(is_default: true) ||
               current_user.statuses.ordered.where.not(id: @status.id).first
    @status.tasks.update_all(status_id: fallback&.id)
    @status.destroy
    redirect_to statuses_path, notice: "Status deleted."
  end

  private

  def set_status
    @status = current_user.statuses.find(params[:id])
  end

  def status_params
    params.require(:status).permit(:name, :color, :position, :is_default)
  end
end