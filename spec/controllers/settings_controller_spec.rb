require 'rails_helper'

RSpec.describe SettingsController, type: :controller do
  login_user

  it 'routes GET / to index' do
    get :index
    expect(response.status).to eq(200)
  end

end
