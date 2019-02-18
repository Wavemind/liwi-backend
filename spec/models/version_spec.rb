require 'rails_helper'

RSpec.describe Version, type: :model do
  it 'is valid with valid attributes' do
    role = Role.new(name: 'administrator')
    user = User.new(first_name: 'Foo', last_name: 'Bar', email: 'foo.bar@gmail.com', role: role)
    algorithm = Algorithm.new(name: 'EPOCT', description: 'MedicalCenter1', user: user)

    version = Version.new(name: '1.3.2', user: user, algorithm: algorithm)
    expect(version).to be_valid
  end

  it 'is invalid with invalid attributes' do
    role = Role.new(name: 'administrator')
    user = User.new(first_name: 'Foo', last_name: 'Bar', email: 'foo.bar@gmail.com', role: role)
    algorithm = Algorithm.new(name: 'EPOCT', description: 'MedicalCenter1', user: user)

    version = Version.new(name: nil, user: user, algorithm: algorithm)
    expect(version).to_not be_valid
  end
end
