require 'rails_helper'

RSpec.describe 'User::Registration', type: :request do
  let(:json) { JSON.parse(response.body).with_indifferent_access }
  let!(:headers) { { ACCEPT: 'application/json', CONTENT_TYPE: 'application/json' } }

  describe 'POST /users/' do
    it 'should create a new user' do
      params = { username: 'Rajil', email: 'rajil@test.com', password: '123456' }
      post('/users/', headers: headers, params: params.to_json)
      expect(response).to have_http_status(200)
    end
  end
end
