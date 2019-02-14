require 'rails_helper'

RSpec.describe Group, type: :model do
  it 'is valid with valid attributes' do
    group = Group.new(name: 'administrator')
    expect(group).to be_valid
  end

  it 'is invalid with invalid attributes' do
    group = Group.new(name: nil)
    expect(group).to_not be_valid
  end

  it 'should add an algorithm to this group' do
    role = Role.new(name: 'administrator')
    user = User.new(first_name: 'Foo', last_name: 'Bar', email: 'foo.bar@gmail.com', role: role)
    algorithm = Algorithm.new(name: 'EPOCT', description: 'MedicalCenter1', user: user)

    version = AlgorithmVersion.new(name: '1.3.2', user: user, algorithm: algorithm)

    group = Group.new(name: 'Test')
    group.algorithm_versions << version

    expect(group.algorithm_versions.first).to eql(version)
  end
end
