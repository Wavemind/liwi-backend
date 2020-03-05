require 'rails_helper'

RSpec.describe DevicesController, type: :controller do
  login_user

  it 'should work for [GET:index]' do
    get :index, xhr: true
    expect(response.status).to eq(200)
  end

  it 'should work for [GET:show]' do
    @device = Device.create!(mac_address: 'BB:3B:AA:69:8F:74', model: 'P50s', brand: 'Lenovo', status: :active, name: 'MedicalCenter1', os: 'Android', os_version: '8.0')
    get :show, params: { id: @device.id }
    expect(response.status).to eq(200)
  end

  it 'should work for [GET:new]' do
    get :new, xhr: true
    expect(response.status).to eq(204)
  end

  it 'should work for [POST:create]' do
    @group_wavemind = Group.create!(name: 'Wavemind', architecture: Group.architectures[:client_server], pin_code: '1234')
    post :create, params: { device: { mac_address: 'asdkjlhaskdjhkhjasdhkjasdkjhasdkjlhaskjdlh', group_id: @group_wavemind.id } }
    expect(response.status).to eq(302)
  end

  it 'return json with activities of devices' do
    get :map

    expect(response.content_type).to eq('application/json')
  end
end
