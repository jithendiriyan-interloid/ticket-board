class BoardsController < ApplicationController
  def index
    @user = current_user 
    @statuses = Status.includes(:tasks)
  end
end
