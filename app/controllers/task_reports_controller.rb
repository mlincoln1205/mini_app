class TaskReportsController < ApplicationController

  # http://localhost:3000/task_reports
  def index
    @comments = Comment.where(user_id: current_user.id).order(body: :asc)
  end
end
