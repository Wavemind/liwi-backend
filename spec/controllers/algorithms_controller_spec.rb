require 'rails_helper'

RSpec.describe AlgorithmsController, type: :controller do
  login_user
  create_answer_type

  before(:each) do
    @user = User.new(first_name: 'Foo', last_name: 'Bar', email: 'foo.bar@gmail.com')
    @algorithm = Algorithm.create!(name: 'EPOCT', description: 'MedicalCenter1', user: @user)
    @archived_algorithm = Algorithm.create!(name: 'EPOCT_old', description: 'MedicalCenter1', user: @user, archived: true)
  end

  it 'archives correctly' do
    put :archive, params: { id: @algorithm.id }
    @algorithm.reload
    expect(@algorithm.archived).to equal(true)
  end

  it 'unarchives correctly' do
    put :unarchive, params: { id: @archived_algorithm.id }
    @archived_algorithm.reload
    expect(@archived_algorithm.archived).to equal(false)
  end

  it 'should work for [GET:index]' do
    get :index
    expect(response.status).to eq(200)
  end

  it 'should work for [GET:show]' do
    get :show, params: { id: @algorithm.id }
    expect(response.status).to eq(200)
  end

  it 'should work for [GET:new]' do
    get :new, xhr: true
    expect(response.status).to eq(200)
  end

  it 'should work for [POST:create]' do
    post :create, params: { algorithm: { name: 'EPOCT', description: 'MedicalCenter1', user: @user } }
    expect(response.status).to eq(200)
  end

  it 'should work for [GET:edit]' do
    get :edit, params: { id: @algorithm.id }
    expect(response.status).to eq(200)
  end

  it 'should work for [PATCH:update]' do
    patch :update, params: { id: @algorithm.id, algorithm: { name: 'EPOCT', description: 'MedicalCenter1', user: @user } }
    expect(response.status).to eq(302)
  end

  it 'should work for [GET:questions]' do
    get :questions, params: { id: @algorithm.id }, xhr: true
    expect(response.status).to eq(204)
  end

  it 'should work for [GET:drugs]' do
    get :drugs, params: { id: @algorithm.id }, xhr: true
    expect(response.status).to eq(204)
  end

  it 'should work for [GET:managements]' do
    get :managements, params: { id: @algorithm.id }, xhr: true
    expect(response.status).to eq(204)
  end

  it 'should work for [GET:questions_sequences]' do
    get :questions_sequences, params: { id: @algorithm.id }, xhr: true
    expect(response.status).to eq(204)
  end

  it 'should work for [GET:questions_sequences_scored]' do
    get :questions_sequences_scored, params: { id: @algorithm.id }, xhr: true
    expect(response.status).to eq(204)
  end

  it 'should not work for [DELETE:destroy]' do
    expect(delete: :destroy).not_to be_routable
  end
end
