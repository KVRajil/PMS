require 'rails_helper'

RSpec.describe Project, type: :model do
  let!(:user) { create(:user) }
  let!(:project) { create(:project, title: 'Sample Project 1', description: 'Test description', user: user) }
  let!(:task) { create(:task, title: 'Sample', description: 'Test', project: project, assignee: user, reporter: user, status: 'yet_to_start') }

  context 'validation test' do
    it 'ensures title presence' do
      task.title = nil
      expect(task).to_not be_valid
    end

    it 'ensures status should be valid' do
      task.status = 'invalid'
      expect(task).to_not be_valid
    end

    it 'ensures title length should not be too long' do
      task.title = [*('AA'..'GG')].sample(250).join
      expect(task).to_not be_valid
    end
  end
end
