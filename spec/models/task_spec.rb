require 'rails_helper'
require 'capybara/rails'

RSpec.describe Task, type: :model do
  it 'Is created with default share status nil' do
    expect(Task.new.share).to eq nil
  end

  it 'Is created with default \'status\' value os 0' do
    expect(Task.new.status.to_i).to eq 0
  end

  it 'Is created with default priority of 0' do
    expect(Task.new.priority.to_i).to eq 0
  end

  context 'Unity test' do 
    it 'Check New Task' do
      user = create(:user)
      login_as(user)
    
      task = Task.new
      task.title = 'New Task'
      task.description = 'Description'
      task.priority = 'low'
      task.user = user

    expect(task.valid?).to be_truthy
    end
  end

  context 'Integration test' do
    it 'Check edit task' do
      user = create(:user)
      profile = create(:profile, user: user)
      login_as(user)
      
      task = Task.new
      task.title = 'New Task'
      task.description = 'Description'
      task.priority = 'low'
      task.user = user
      task.save

      visit "/tasks/#{user.tasks.last.id}/edit"

      find('.edit_task') do
        fill_in 'task[status]', with: 'complete'
      end

      click_button 'Update Task'
      expect(page).to have_content('Task was successfully updated!')
    end
  end
end