class StatusController < ApplicationController
  def create
    Status.create!(name: params[:name])
    redirect_to board_path
  end
end
