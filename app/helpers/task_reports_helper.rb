module TaskReportsHelper
  
  def complete_tasks
    @comments.select { |comment| comment.task.status == 'complete' }
  end
end
