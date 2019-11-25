require 'rails_helper'

RSpec.describe GroupAccess, type: :model do
  create_answer_type
  create_version

  before(:each) do
    @group = Group.new(name: 'ILoveTestUnits', architecture: Group.architectures[:standalone], pin_code: '1234')
  end

  it 'is valid with valid attributes' do
    group_access = GroupAccess.new(version: @version, group: @group)
    expect(group_access).to be_valid
    expect(group_access.access).to eq(true)
    expect(group_access.end_date).to eq(nil)
  end

  it 'is invalid with invalid attributes' do
    group_access = GroupAccess.new(version: nil, group: @group)
    expect(group_access).to_not be_valid
  end

  it 'is archived previous algorithm access' do
    group_access = GroupAccess.create!(version: @version, group: @group)
    GroupAccess.create!(version: @version, group: @group)

    group_access.reload

    expect(group_access.access).to eq(false)
    expect(group_access.end_date).to_not eq(nil)
  end

end
