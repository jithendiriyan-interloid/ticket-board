class BoardsController < ApplicationController
  def index
    @user = current_user 
    @statuses = Status.includes(:tasks)
      @new_status_form = params[:new_status].present?
  end
end
