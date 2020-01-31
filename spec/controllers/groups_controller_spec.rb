require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  login_user

  before(:each) do
    @group = Group.create!(name: 'administrator', architecture: Group.architectures[:standalone], pin_code: '1234')
    @device = Device.create!(mac_address: 'BB:3B:AA:69:8F:74', model: 'P50s', brand: 'Lenovo', status: :active, name: 'MedicalCenter1', os: 'Android', os_version: '8.0')
  end

  it 'add device' do
    post :add_device, params: { group_id: @group.id, device: { id: @device.id } }
    @device.reload
    expect(@device.group_id).to equal(@device.id)
  end

  it 'remove device' do
    post :add_device, params: { group_id: @group.id, device: { id: @device.id } }
    @device.reload

    delete :remove_device, params: { group_id: @group.id, device_id: @device.id }
    @device.reload

    expect(@device.group_id).to equal(nil)
  end
end
