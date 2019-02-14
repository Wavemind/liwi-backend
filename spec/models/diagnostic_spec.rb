require 'rails_helper'

RSpec.describe Diagnostic, type: :model do

  before(:each) do
    role = Role.new(name: 'administrator')
    user = User.new(first_name: 'Foo', last_name: 'Bar', email: 'foo.bar@gmail.com', role: role)
    algorithm = Algorithm.new(name: 'EPOCT', description: 'MedicalCenter1', user: user)

    @version = AlgorithmVersion.create!(name: '1.3.2', user: user, algorithm: algorithm)
  end

  it 'is valid with valid attributes' do
    diagnostic = Diagnostic.new(algorithm_version: @version, reference: '1', label: 'lower respiratory tract infection (LRTI)')

    expect(diagnostic).to be_valid
  end

  it 'is invalid with invalid attributes' do
    diagnostic = Diagnostic.new(algorithm_version: @version, reference: '1', label: nil)

    expect(diagnostic).to_not be_valid
  end

  it 'is invalid same reference' do
    Diagnostic.create!(algorithm_version: @version, reference: '1', label: 'lower respiratory tract infection (LRTI)')
    diagnostic = Diagnostic.new(algorithm_version: @version, reference: '1', label: 'lower respiratory tract infection (LRTI)')

    expect(diagnostic).to_not be_valid
  end
end
