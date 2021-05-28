class TasksController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create destroy search]
  before_action :user_profile?
  before_action :find_task, only: %i[edit update show confirm_delete destroy delete_comment]
  skip_before_action :verify_authenticity_token, only: %i[search]
    
  def index
    @tasks = Task.all.where(user_id: current_user.id).order(id: :desc)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      redirect_to tasks_path, notice: 'Task was successfully created!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Task was successfully updated!'
    else
      redirect_to tasks_path, notice: 'Task wasn\'t updated!'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  def complete
    # This parameter is handled on edit form since when it's created by default is "incomplete"
  end

  def incomplete
    # This parameter is handled on edit form since when it's created by default is "incomplete"
  end

  private

  def find_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :priority, :status, :share)
  end  

  def comment_params
    # comments are are been treated on comments controller
    # params.require(:comment).permit(:body, :like_status)
  end 

  def sanitize_sql_like(string, escape_character = "\\")
    pattern = Regexp.union(escape_character, "%", "_")
    string.gsub(pattern) { |x| [escape_character, x].join }
  end
end

