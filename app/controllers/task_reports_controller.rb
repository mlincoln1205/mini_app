class TaskReportsController < ApplicationController

  # http://localhost:3000/task_reports
  def index
    @tasks = Task.where(user: current_user).order(created_at: :desc)
    @comments = Comment.where(user: current_user).order(body: :asc)
  end
end
