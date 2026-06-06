class CommentsController < ApplicationController
  before_action :set_task
  before_action :set_comment, only: [:update, :destroy]

  def create
    @comment = @task.comments.build(comment_params.merge(user: current_user))
    @comment.save
  end
  
  def update
    @comment.update(comment_params)
  end
  def destroy
    @comment.destroy
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def set_comment
    @comment = @task.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:description)
  end
end