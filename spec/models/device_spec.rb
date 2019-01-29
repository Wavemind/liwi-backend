require 'rails_helper'

RSpec.describe Device, type: :model do
  it 'is valid with valid attributes' do
    device = Device.new(mac_address: 'BB-3B-AA-69-8F-74', model: 'P50s', brand: 'Lenovo', status: :active, name: 'MedicalCenter1', os: 'Android', os_version: '8.0')
    expect(device).to be_valid
  end

  it 'is invalid with invalid attributes' do
    device = Device.new(mac_address: nil, model: nil, brand: 'Lenovo', status: :active, name: 'MedicalCenter1', os: 'Android')
    expect(device).to_not be_valid
  end
end
