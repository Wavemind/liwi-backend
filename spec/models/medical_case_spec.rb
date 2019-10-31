require 'rails_helper'

RSpec.describe MedicalCase, type: :model do
  create_answer_type
  create_algorithm

  before(:each) do
    @version = Version.create!(name: '1.0', user: @user, algorithm: @algorithm)
    @patient = Patient.create!(first_name: 'John', last_name: 'Do')

    boolean = AnswerType.create!(value: 'Boolean', display: 'RadioButton')
    @cc = @algorithm.questions.create!(reference: '11', answer_type: boolean, label_en: 'CC11', stage: Question.stages[:triage], priority: Question.priorities[:mandatory], type: 'Questions::ChiefComplaint')
  end

  it 'is valid with valid attributes' do
    medical_case = MedicalCase.new(version: @version, patient: @patient)
    expect(medical_case).to be_valid
  end

  it 'is invalid with invalid attributes' do
    medical_case = MedicalCase.new(version: @version, patient: nil)
    expect(medical_case).to_not be_valid
  end

  it 'can include health cares' do
    treatment = HealthCares::Treatment.create!(reference: '9', label_en: 'skin issue', algorithm: @algorithm)
    management = HealthCares::Management.create!(reference: '9', label_en: 'skin issue', algorithm: @algorithm)

    medical_case = MedicalCase.new(version: @version, patient: @patient)
    medical_case.nodes << [management, treatment]

    expect(medical_case).to be_valid
  end

  it 'cannot include a node which is not a health care (Management/Treatment)' do
    predefined_syndrome = QuestionsSequences::PredefinedSyndrome.create!(reference: '9', label_en: 'skin issue', algorithm: @algorithm)

    medical_case = MedicalCase.new(version: @version, patient: @patient)
    medical_case.nodes << predefined_syndrome

    expect(medical_case).to_not be_valid
  end

  it 'can include a final diagnostic' do
    diagnostic = Diagnostic.create!(reference: '9', label_en: 'diagnostic', version: @version, node: @cc)
    final_diagnostic = FinalDiagnostic.create!(reference: '9', label_en: 'skin issue', diagnostic: diagnostic)

    medical_case = MedicalCase.new(version: @version, patient: @patient)
    medical_case.final_diagnostics << final_diagnostic

    expect(medical_case).to be_valid
  end

end
