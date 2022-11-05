require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Api::V1::Task', type: :request do
  let(:json) { JSON.parse(response.body).with_indifferent_access }
  let!(:user) { create(:user) }
  let!(:project) { create(:project, title: 'Sample Project 1', description: 'Test description', user: user) }
  let!(:task) { create(:task, title: 'Sample', description: 'Test', project: project, assignee: user, reporter: user, status: 'yet_to_start') }
  let!(:headers) { { ACCEPT: 'application/json', CONTENT_TYPE: 'application/json' } }

  describe 'GET /api/v1/projects/:project_id/tasks' do
    it 'should return the paginated tasks' do
      authenticated_header = AuthToken.authenticated_header(headers, user)
      params = { page: 1, per_page: 10 }
      get("/api/v1/projects/#{project.id}/tasks", headers: authenticated_header, params: params)
      expect(response).to have_http_status(200)
      expect(json.keys).to match_array(%w[tasks meta])
      expect(json[:tasks].sample.keys).to match_array(%w[id title description assignee reporter status project start_date end_date])
      expect(json[:meta].keys).to match_array(%w[current_page total_pages total_count])
    end
  end

  describe 'GET /api/v1/projects/:project_id/tasks/:id' do
    it 'should return the task details' do
      authenticated_header = AuthToken.authenticated_header(headers, user)
      get("/api/v1/projects/#{project.id}/tasks/#{task.id}", headers: authenticated_header)
      expect(response).to have_http_status(200)
      expect(json.keys).to match_array(%w[task])
      expect(json[:task].keys).to match_array(%w[id title description assignee reporter status project start_date end_date])
    end
  end

  describe 'POST /api/v1/projects/:project_id/tasks/' do
    it 'should create a task' do
      authenticated_header = AuthToken.authenticated_header(headers, user)
      params = { title: 'Test title', description: 'Test description', status: 'yet_to_start' }
      post("/api/v1/projects/#{project.id}/tasks/", headers: authenticated_header, params: params.to_json)
      expect(response).to have_http_status(200)
    end
  end

  describe 'PUT /api/v1/projects/:project_id/tasks/:id' do
    it 'should update task attributes' do
      authenticated_header = AuthToken.authenticated_header(headers, user)
      params = { assignee_id: user.id, reporter_id: user.id, title: 'new title', description: 'new description',
                 status: 'in_progress', start_date: Time.zone.today, end_date: Time.zone.tomorrow }
      put("/api/v1/projects/#{project.id}/tasks/#{task.id}", headers: authenticated_header, params: params.to_json)
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE /api/v1/projects/:project_id/tasks/:id' do
    it 'should destroy a task ' do
      authenticated_header = AuthToken.authenticated_header(headers, user)
      delete("/api/v1/projects/#{project.id}/tasks/#{task.id}", headers: authenticated_header)
      expect(response).to have_http_status(200)
    end
  end
end
