require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  login_user

  before(:each) do
    role = Role.new(name: 'administrator')
    @user = User.create!(first_name: 'Foo', last_name: 'Bar', email: 'foo.bar@gmail.com', role: role)
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
