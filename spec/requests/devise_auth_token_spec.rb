require 'rails_helper'
include ActionController::RespondWith

# The authentication header looks something like this:
# {"access-token"=>"abcd1dMVlvW2BT67xIAS_A", "token-type"=>"Bearer", "client"=>"LSJEVZ7Pq6DX5LXvOWMq1w", "expiry"=>"1519086891", "uid"=>"darnell@konopelski.info"}

describe 'Whether access is ocurring properly', type: :request do
  before(:each) do
    # needed for algorithm creation for auto created questions
    boolean = AnswerType.create!(value: 'Boolean', display: 'RadioButton')
    dropdown_list = AnswerType.create!(value: 'Array', display: 'DropDownList')
    input_integer = AnswerType.create!(value: 'Integer', display: 'Input')
    input_float = AnswerType.create!(value: 'Float', display: 'Input')
    formula = AnswerType.create!(value: 'Float', display: 'Formula')
    date = AnswerType.create!(value: 'Date', display: 'Input')
    string = AnswerType.create!(value: 'String', display: 'Input')

    @current_user = User.create(first_name: 'Foo', last_name: 'Bar', email: 'foo.bar@ilovetestunit.com', password: '123456', password_confirmation: '123456')
    group_wavemind = Group.create!(name: 'Wavemind', architecture: Group.architectures[:standalone], pin_code: '1234')
    Device.create!(mac_address: '64:DB:43:D5:31:5C', group: group_wavemind)

    epoct = Algorithm.create!(name: 'ePoct', description: 'loremp ipsum', user: @current_user)
    epoc_first = Version.create!(name: 'first_trial', algorithm: epoct, user: @current_user)

    group_wavemind.versions << epoc_first
    group_wavemind.save
  end

  context 'context: general authentication via API, ' do
    it 'doesn\'t give you anything if you don\'t log in' do
      get api_v1_versions_url()
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

    it 'first get a token, then try to access without mac_address to a restricted page' do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      get api_v1_versions_url, headers: auth_params
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'first get a token, then try to access with mac_address to a restricted page' do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      get api_v1_versions_url, headers: auth_params, params: { mac_address: '64:DB:43:D5:31:5C' }
      expect(response).to have_http_status(:success)
    end

    it 'deny access to a restricted page with an incorrect token' do
      login
      auth_params = get_auth_params_from_login_response_headers(response).tap { |h| h.each { |k, v|
        if k == 'access-token'
          h[k] = '123'
        end }
      }

      get api_v1_versions_url, headers: auth_params
      expect(response).not_to have_http_status(:success)
    end
  end

  def login
    post api_v1_user_session_url, params: { email: @current_user.email, password: '123456' }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
  end

  def get_auth_params_from_login_response_headers(response)
    client = response.headers['client']
    token = response.headers['access-token']
    expiry = response.headers['expiry']
    token_type = response.headers['token-type']
    uid = response.headers['uid']

    {
      'access-token' => token,
      'client' => client,
      'uid' => uid,
      'expiry' => expiry,
      'token_type' => token_type
    }
  end
end
