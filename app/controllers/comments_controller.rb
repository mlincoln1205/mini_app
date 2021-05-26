class CommentsController < ApplicationController
  before_action :comment_owner?, only: %i[index]

  def index
    @comments = Comment.where(user: current_user)
    if params[:order].in? %w[new old]
      case params[:order]
      when 'new'
        @comments.order!(created_at: :desc)
      when 'old'
        @comments.order!(:created_at)
      end
    end
  end 

  def new
    @task = Task.find(params[:task_id])
    @comment = Comment.new
  end

  def create
    @task = Task.find(params[:task_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.task = @task
    if @comment.save
      redirect_to tasks_path
    else
      render :new, notice: 'Comment could not be created'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :like_status)
  end 

  def comment_owner?
    @profile = Profile.find(params[:profile_id])
    if !current_user
      redirect_to root_path
    elsif (current_user.profile != @profile and !@profile.share )
      redirect_to root_path
    end
  end
end

