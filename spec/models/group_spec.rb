require 'rails_helper'

RSpec.describe Group, type: :model do
  it 'is valid with valid attributes' do
    group = Group.new(name: 'administrator', architecture: Group.architectures[:standalone], pin_code: '1234')
    expect(group).to be_valid
  end

  it 'is invalid with invalid attributes' do
    group = Group.new(name: nil, architecture: Group.architectures[:standalone], pin_code: '1234')
    expect(group).to_not be_valid
  end

  it 'should add an algorithm to this group' do
    role = Role.new(name: 'administrator')
    user = User.new(first_name: 'Foo', last_name: 'Bar', email: 'foo.bar@gmail.com')
    algorithm = Algorithm.new(name: 'EPOCT', description: 'MedicalCenter1', user: user)

    version = Version.new(name: '1.3.2', user: user, algorithm: algorithm)

    group = Group.new(name: 'Test', architecture: Group.architectures[:standalone], pin_code: '1234')
    group.versions << version

    expect(group.versions.first).to eql(version)
  end
end
