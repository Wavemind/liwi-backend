require 'rails_helper'

RSpec.describe VersionsController, type: :controller do
  login_user
  create_answer_type
  create_algorithm
  create_instances

  before(:each) do
    @user = User.new(first_name: 'Foo', last_name: 'Bar', email: 'foo.bar@gmail.com')
    @algorithm = Algorithm.new(name: 'EPOCT', description: 'MedicalCenter1', user: @user)

    @version = Version.create!(name: 'final', algorithm: @algorithm, user: @user)
    @archived_version = Version.create!(name: 'obsolete', algorithm: @algorithm, user: @user, archived: true)
  end

  it 'archives correctly' do
    put :archive, params: { algorithm_id: @algorithm.id, id: @version.id }
    @version.reload
    expect(@version.archived).to equal(true)
  end

  it 'unarchives correctly' do
    put :unarchive, params: { algorithm_id: @algorithm.id, id: @archived_version.id }
    @archived_version.reload
    expect(@archived_version.archived).to equal(false)
  end

  it 'should work for [GET:index]' do
    get :index, params: { algorithm_id: @algorithm.id }, xhr: true
    expect(response.status).to eq(204)
  end

  it 'should work for [GET:show]' do
    get :show, params: { algorithm_id: @algorithm.id, id: @version.id }
    expect(response.status).to eq(200)
  end

  it 'should work for [GET:new]' do
    get :new, params: { algorithm_id: @algorithm.id }
    expect(response.status).to eq(200)
  end

  it 'should work for [POST:create]' do
    post :create, params: { algorithm_id: @algorithm.id, version: { name: 'final', algorithm: @algorithm, user: @user } }
    expect(response.status).to eq(200)
  end

  it 'should work for [GET:edit]' do
    get :edit, params: { algorithm_id: @algorithm.id, id: @version.id }
    expect(response.status).to eq(200)
  end

  it 'should work for [PATCH:update]' do
    patch :update, params: { algorithm_id: @algorithm.id, id: @version.id, version: { name: 'final', algorithm: @algorithm, user: @user } }
    expect(response.status).to eq(302)
  end

  it 'should work for [PUT:change_triage_order]' do
    put :change_triage_order, params: { algorithm_id: @algorithm.id, id: @version.id, key: 'triage_questions_order', order: 4 }
    expect(response.status).to eq(200)
  end

  # TODO @MANU more test should be done here
  it 'should work for [PUT:create_triage_condition]' do
    put :create_triage_condition, params: { algorithm_id: @algorithm.id, id: @version.id, version: { cc_id: nil } }
    expect(response.status).to eq(302)
  end

  it 'should work for [PUT:remove_triage_condition]' do
    put :remove_triage_condition, params: { algorithm_id: @algorithm.id, id: @version.id, condition_id: @cond1.id }
    expect(response.status).to eq(302)
  end

  it 'should not work for [DELETE:destroy]' do
    expect(delete: :destroy).not_to be_routable
  end
end
