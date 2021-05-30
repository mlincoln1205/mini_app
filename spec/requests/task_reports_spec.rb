require 'rails_helper'
require 'capybara/rails'

RSpec.describe "TaskReports", type: :request do
  describe 'Integration Test' do
    it 'Check list of Comments Alphabetically' do
      user = create(:user)
      profile = create(:profile, user: user)
      login_as(user)

      visit "/task_reports"
      expect(page).to have_selector('h4', text: 'Comments by Alphabetical Order')
    end
    
    it 'Check list of Tasks' do
      user = create(:user)
      profile = create(:profile, user: user)
      login_as(user)

      visit "/task_reports"
      expect(page).to have_selector('h4', text: 'Completed Tasks')
    end

    it 'Returns only complete tasks' do
      user = create(:user)
      profile = create(:profile, user: user)
      login_as(user)
  
      task = Task.new
      task.title = 'New Task'
      task.description = 'Description'
      task.priority = 'low'
      task.user = user
      task.save
  
      visit "/tasks/#{user.tasks.first.id}/edit"
  
      find('.edit_task') do
        fill_in 'task[status]', with: 'complete'
      end
  
      click_button 'Update Task'
  
      visit "/task_reports"
      expect(page).not_to have_content('incomplete')
    end
  end
end
  

  