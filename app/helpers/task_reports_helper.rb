module TaskReportsHelper
  
  def complete_tasks_comments
    @comments.select { |comment| comment.task.status == 'complete' }
  end

  def complete_tasks
    @tasks.select { |task| task.status == 'complete' }
  end
  
end
