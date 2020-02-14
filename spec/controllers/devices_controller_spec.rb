require 'rails_helper'

RSpec.describe DevicesController, type: :controller do
  login_user

  it 'return json with activities of devices' do
    get :map

    expect(response.content_type).to eq('application/json')
  end
end
