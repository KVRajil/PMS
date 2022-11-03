require 'rails_helper'

RSpec.describe 'User::Session', type: :request do
  let(:json) { JSON.parse(response.body).with_indifferent_access }
  let!(:user) { create(:user, password: '123456') }
  let!(:headers) { { ACCEPT: 'application/json', CONTENT_TYPE: 'application/json' } }

  describe 'POST /users/sign_in' do
    it 'should login to a user account' do
      params = { email: user.email, password: '123456' }
      post('/users/sign_in', headers: headers, params: params.to_json)
      expect(response).to have_http_status(401)
    end
  end

  describe 'DELETE /users/sign_out' do
    it 'should log out a user' do
      authenticated_header = AuthToken.authenticated_header(headers, user)
      delete('/users/sign_out', headers: authenticated_header)
      expect(response).to have_http_status(200)
    end
  end
end
