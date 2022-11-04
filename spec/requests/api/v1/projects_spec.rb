require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Api::V1::Projects', type: :request do
  let(:json) { JSON.parse(response.body).with_indifferent_access }
  let!(:user) { create(:user) }
  let!(:project) { create(:project, title: 'Sample Project 1', description: 'Test description', user: user) }
  let!(:headers) { { ACCEPT: 'application/json', CONTENT_TYPE: 'application/json' } }

  describe 'GET /api/v1/projects' do
    it 'should return the paginated projects' do
      authenticated_header = AuthToken.authenticated_header(headers, user)
      params = { page: 1, per_page: 10 }
      get('/api/v1/projects', headers: authenticated_header, params: params)
      expect(response).to have_http_status(200)
      expect(json.keys).to match_array(%w[projects meta])
      expect(json[:projects].sample.keys).to match_array(%w[id title description user])
      expect(json[:projects].sample[:user].keys).to match_array(%w[id username])
      expect(json[:meta].keys).to match_array(%w[current_page total_pages total_count])
    end
  end

  describe 'GET /api/v1/projects/:id' do
    it 'should return the project details' do
      authenticated_header = AuthToken.authenticated_header(headers, user)
      get("/api/v1/projects/#{project.id}", headers: authenticated_header)
      expect(response).to have_http_status(200)
      expect(json.keys).to match_array(%w[project])
      expect(json[:project].keys).to match_array(%w[id title description user])
      expect(json[:project][:user].keys).to match_array(%w[id username])
    end
  end

  describe 'POST /api/v1/projects/' do
    it 'should create a project' do
      authenticated_header = AuthToken.authenticated_header(headers, user)
      params = { title: 'Test title', description: 'Test description' }
      post('/api/v1/projects/', headers: authenticated_header, params: params.to_json)
      expect(response).to have_http_status(200)
    end
  end

  describe 'PUT /api/v1/projects/' do
    it 'should update a project title' do
      authenticated_header = AuthToken.authenticated_header(headers, user)
      params = { title: 'Test title new' }
      put("/api/v1/projects/#{project.id}", headers: authenticated_header, params: params.to_json)
      expect(response).to have_http_status(200)
    end
  end
end
