require 'rails_helper'

RSpec.describe Project, type: :model do
  let!(:user) { create(:user) }
  let!(:project) { create(:project, title: 'Sample Project 1', description: 'Test description', user: user) }

  context 'validation test' do
    it 'ensures title presence' do
      project.title = nil
      expect(project).to_not be_valid
    end

    it 'ensures user_id presence' do
      project.user_id = nil
      expect(project).to_not be_valid
    end

    it 'ensures title length should not be too long' do
      project.title = [*('AA'..'GG')].sample(150).join('')
      expect(project).to_not be_valid
    end
  end
end
