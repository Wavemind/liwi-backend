require 'rails_helper'
include ActionController::RespondWith

# The authentication header looks something like this:
# {"access-token"=>"abcd1dMVlvW2BT67xIAS_A", "token-type"=>"Bearer", "client"=>"LSJEVZ7Pq6DX5LXvOWMq1w", "expiry"=>"1519086891", "uid"=>"darnell@konopelski.info"}

describe 'Whether access is ocurring properly', type: :request do
  before(:each) do
    role = Role.create(name: 'administrator')
    @current_user = User.create(first_name: 'Foo', last_name: 'Bar', email: 'foo.bar@ilovetestunit.com', password: '123456', password_confirmation: '123456', role: role)
  end

  context 'context: general authentication via API, ' do
    it 'doesn\'t give you anything if you don\'t log in' do
      get api_v1_algorithm_versions_url()
      expect(response.status).to eq(401)
    end

    it 'gives you an authentication code if you are an existing user and you satisfy the password' do
      login
      expect(response.has_header?('access-token')).to eq(true)
    end

    it 'gives you a status 200 on signing in ' do
      login
      expect(response.status).to eq(200)
    end

    it 'gives you an authentication code if you are an existing user and you satisfy the password' do
      login
      expect(response.has_header?('access-token')).to eq(true)
    end

    it 'first get a token, then access a restricted page' do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      get api_v1_algorithm_versions_url, headers: auth_params
      expect(response).to have_http_status(:success)
    end

    it 'deny access to a restricted page with an incorrect token' do
      login
      auth_params = get_auth_params_from_login_response_headers(response).tap { |h| h.each{|k,v|
        if k == 'access-token'
          h[k] = '123'
        end}
      }

      get api_v1_algorithm_versions_url, headers: auth_params
      expect(response).not_to have_http_status(:success)
    end
  end

  def login
    post api_v1_user_session_url, params:  { email: @current_user.email, password: '123456'}.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
  end

  def get_auth_params_from_login_response_headers(response)
    client = response.headers['client']
    token = response.headers['access-token']
    expiry = response.headers['expiry']
    token_type = response.headers['token-type']
    uid =   response.headers['uid']

    {
      'access-token' => token,
      'client' => client,
      'uid' => uid,
      'expiry' => expiry,
      'token_type' => token_type
    }
  end
end
