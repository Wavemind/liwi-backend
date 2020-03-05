require 'rails_helper'

RSpec.describe TechnicalFilesController, type: :controller do
  login_user

  it 'routes GET / to index' do
    get :index
    expect(response.status).to eq(200)
  end

  it 'routes POST / to create' do
    post :create, params: { technical_file: { id: 1, file: 'newfile' } }
    expect(response.status).to eq(302)
  end

end
