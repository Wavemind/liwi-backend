require 'rails_helper'

RSpec.describe Activity, type: :model do
  it 'is valid with valid attributes' do
    device = Device.new(reference_number: 'XXASDFG233GGSAAA5', model: 'P50s', brand: 'Lenovo', status: :active, os: 'Android', os_version: '8.0', name: 'MedicalCenter1')
    activity = Activity.new(latitude: -3.067422, longitude: 37.355625, device: device, timezone: 'Berne', version: '1.0.0')
    expect(activity).to be_valid
  end

  it 'is invalid with invalid attributes' do
    activity = Activity.new(latitude: '-3.067422', longitude: '37.355625', timezone: 'Berne', version: '1.0.0')
    expect(activity).to_not be_valid
  end
end
