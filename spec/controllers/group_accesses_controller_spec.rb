require 'rails_helper'

RSpec.describe GroupAccessesController, type: :controller do
  login_user
  create_answer_type
  create_version

  it 'should work for [GET:index]' do
    get :index, xhr: true
    expect(response.status).to eq(204)
  end

  it 'should work for [POST:create]', focus: :true do
    @standalone = Group.create!(name: 'Standalone test', architecture: Group.architectures[:standalone], pin_code: '1234')

    post :create, params: { group_access: { version_id: @version.id, group_id: @standalone.id } }
    expect(response.status).to eq(302)
  end
end
