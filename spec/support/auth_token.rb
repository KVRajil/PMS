module AuthToken
  module_function

  def authenticated_header(headers, user)
    auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
    headers.merge!(auth_headers)
  end
end
