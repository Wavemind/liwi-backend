require 'rails_helper'

RSpec.describe UsersController, type: :controller, focus: :true do
  login_user

  before(:each) do
    @user = User.create!(first_name: 'Foo', last_name: 'Bar', email: 'foo.bar@gmail.com')
  end

  it 'should work for [GET:index]' do
    get :index
    expect(response.status).to eq(200)
  end

  it 'should work for [GET:show]' do
    get :show, params: { id: @user.id }
    expect(response.status).to eq(200)
  end

  it 'should work for [GET:new]' do
    get :new, xhr: true
    expect(response.status).to eq(200)
  end

  it 'should work for [POST:create]' do
    post :create, params: { user: { first_name: 'John', last_name: 'Doe', email: 'john.doe@gmail.com' } }
    expect(response.status).to eq(200)
  end

  it 'should work for [GET:edit]' do
    get :edit, params: { id: @user.id }
    expect(response.status).to eq(200)
  end

  it 'should work for [PATCH:update]' do
    patch :update, params: { id: @user.id, user: { first_name: 'John', last_name: 'Doe', email: 'john.doe@gmail.com' } }
    expect(response.status).to eq(302)
  end

  it 'active correctly' do
    post :activated, params: {id: @user.id}
    expect(@user.deactivated).to equal(false)
  end

  it 'deactivated correctly' do
    post :deactivated, params: {id: @user.id}
    @user.reload
    expect(@user.deactivated).to equal(true)
  end
end
