require 'rails_helper'

RSpec.describe LanguagesController, type: :controller do
  login_user

  it 'routes GET / to new' do
    get :new
    expect(response.status).to eq(200)
  end

  it 'routes POST / to create' do
    post :create, params: { language: { id: 1, name: 'newfile', code: 'lecode' } }
    expect(response.status).to eq(302)
  end

  it 'routes PATCH / to update' do
    Language.create!(name: 'test', code: 'FR')
    patch :update, params: { id: 1, language: { id: 1, name: 'newfile', code: 'lecode' } }
    expect(response.status).to eq(302)
  end

  it 'routes DELETE / to destroy' do
    Language.create!(name: 'test', code: 'FR')
    delete :destroy, params: { id: 1 }
    expect(response.status).to eq(302)
  end

end
