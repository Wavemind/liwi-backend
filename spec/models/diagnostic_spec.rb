require 'rails_helper'

RSpec.describe Diagnostic, type: :model do

  before(:each) do
    role = Role.new(name: 'administrator')
    user = User.new(first_name: 'Foo', last_name: 'Bar', email: 'foo.bar@gmail.com', role: role)
    algorithm = Algorithm.new(name: 'EPOCT', description: 'MedicalCenter1', user: user)

    @version = AlgorithmVersion.create!(version: '1.3.2', json: '{}', user: user, algorithm: algorithm)
  end

  it 'is valid with valid attributes' do
    diagnostic = Diagnostic.new(reference: '1', label: 'lower respiratory tract infection (LRTI)')
    diagnostic.algorithm_versions << @version

    expect(diagnostic).to be_valid
  end

  it 'is invalid with invalid attributes' do
    diagnostic = Diagnostic.new(reference: '1', label: nil)
    diagnostic.algorithm_versions << @version

    expect(diagnostic).to_not be_valid
  end

  it 'is invalid same reference' do
    diagnostic_1 = Diagnostic.create!(reference: '1', label: 'lower respiratory tract infection (LRTI)')
    diagnostic_1.algorithm_versions << @version

    diagnostic = Diagnostic.new(reference: '1', label: 'lower respiratory tract infection (LRTI)')
    diagnostic.algorithm_versions << @version

    expect(diagnostic).to_not be_valid
  end
end
