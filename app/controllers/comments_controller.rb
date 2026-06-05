class CommentsController < ApplicationController
  before_action :set_task

  def create
    @comment = @task.comments.build(comment_params.merge(user: current_user))
    @comment.save
    redirect_to @task
  end

  def destroy
    @task.comments.find(params[:id]).destroy
    redirect_to @task
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def comment_params
    params.require(:comment).permit(:description)
  end
end