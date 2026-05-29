class StatusController < ApplicationController
  def new
    @status = Status.new
  end

  def create
    @status = Status.new(status_params)
    if @status.save
      redirect_to boards_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def status_params
    params.require(:status).permit(:name)
  end
end