require 'rails_helper'

RSpec.describe VersionsController, type: :controller do
  login_user

  before(:each) do
    user = User.new(first_name: 'Foo', last_name: 'Bar', email: 'foo.bar@gmail.com')
    @algorithm = Algorithm.new(name: 'EPOCT', description: 'MedicalCenter1', user: user)

    @version = Version.create!(name: 'final', algorithm: @algorithm, user: user)
    @archived_version = Version.create!(name: 'obsolete', algorithm: @algorithm, user: user, archived: true)
  end

  it 'archives correctly' do
    put :archive, params: {algorithm_id: @algorithm.id, id: @version.id}
    @version.reload
    expect(@version.archived).to equal(true)
  end

  it 'unarchives correctly' do
    put :unarchive, params: {algorithm_id: @algorithm.id, id: @archived_version.id}
    @archived_version.reload
    expect(@archived_version.archived).to equal(false)
  end
end
