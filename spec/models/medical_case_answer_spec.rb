require 'rails_helper'

RSpec.describe MedicalCaseAnswer, type: :model do
  create_answer_type
  create_algorithm
  create_version
  create_question

  before(:each) do
    patient = Patient.create!(first_name: 'John', last_name: 'Do')
    @medical_case = MedicalCase.new(version: @version, patient: patient)
  end

  it 'is valid with valid attributes' do
    medical_case_answer = MedicalCaseAnswer.new(value: '75', version: @version, medical_case: @medical_case, answer: @question.answers.first)
    expect(medical_case_answer).to be_valid
  end

  it 'is invalid with invalid attributes' do
    medical_case_answer = MedicalCaseAnswer.new(medical_case: @medical_case, answer: @question.answers.first)
    expect(medical_case_answer).to_not be_valid
  end
end
