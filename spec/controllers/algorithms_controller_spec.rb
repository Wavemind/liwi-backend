require 'rails_helper'

RSpec.describe AlgorithmsController, type: :controller do
  login_user
  create_answer_type

  before(:each) do
    role = Role.new(name: 'administrator')
    user = User.new(first_name: 'Foo', last_name: 'Bar', email: 'foo.bar@gmail.com', role: role)
    @algorithm = Algorithm.create!(name: 'EPOCT', description: 'MedicalCenter1', user: user)
    @archived_algorithm = Algorithm.create!(name: 'EPOCT_old', description: 'MedicalCenter1', user: user, archived: true)
  end

  it 'archives correctly' do
    put :archive, params: {id: @algorithm.id}
    @algorithm.reload
    expect(@algorithm.archived).to equal(true)
  end

  it 'unarchives correctly' do
    put :unarchive, params: {id: @archived_algorithm.id}
    @archived_algorithm.reload
    expect(@archived_algorithm.archived).to equal(false)
  end
end
