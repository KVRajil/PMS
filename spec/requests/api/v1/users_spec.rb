require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Api::V1::User', type: :request do
  let(:json) { JSON.parse(response.body).with_indifferent_access }
  let!(:headers) { { ACCEPT: 'application/json', CONTENT_TYPE: 'application/json' } }
  let!(:user) { create(:user) }

  describe 'GET /api/v1/users' do
    it 'should return the paginated users' do
      authenticated_header = AuthToken.authenticated_header(headers, user)
      params = { page: 1, per_page: 10 }
      get('/api/v1/users', headers: authenticated_header, params: params)
      expect(response).to have_http_status(200)
      expect(json.keys).to match_array(%w[users meta])
      expect(json[:users].sample.keys).to match_array(%w[id username email])
      expect(json[:meta].keys).to match_array(%w[current_page total_pages total_count])
    end
  end
end
