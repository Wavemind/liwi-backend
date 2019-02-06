require 'rails_helper'

RSpec.describe AlgorithmVersionsController, type: :controller do
  login_user

  before(:each) do
    role = Role.new(name: 'administrator')
    user = User.new(first_name: 'Foo', last_name: 'Bar', email: 'foo.bar@gmail.com', role: role)
    @algorithm = Algorithm.new(name: 'EPOCT', description: 'MedicalCenter1', user: user)

    @version = AlgorithmVersion.create!(version: 'final', algorithm: @algorithm, user: user)
    @archived_version = AlgorithmVersion.create!(version: 'obsolete', algorithm: @algorithm, user: user, archived: true)
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
