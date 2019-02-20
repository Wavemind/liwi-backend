module ModelMacros
  def create_algorithm
    before(:each) do
      role_administrator = Role.create!(name: 'Administrator')
      @user = User.create!(first_name: 'Alain', last_name: 'Fresco', email: 'alain.fresco@wavemind.ch', password: '123456', password_confirmation: '123456', role: role_administrator)
      @algorithm = Algorithm.create!(name: 'ePoct', user: @user)
    end
  end

  def create_answer_type
    before(:each) do
      @input_integer = AnswerType.create!(value: 'Integer', display: 'Input')
      @boolean = AnswerType.create!(value: 'Boolean', display: 'RadioButton')
    end
  end

  def create_condition
    before(:each) do
      @physical_exam = Category.create!(name_en: 'Physical exam', reference_prefix: 'P')
      @symptom = Category.create!(name_en: 'Symptom', reference_prefix: 'S')
    end
  end

  def create_diagnostic
    before(:each) do
      role_administrator = Role.create!(name: 'Administrator')
      user = User.create!(first_name: 'Alain', last_name: 'Fresco', email: 'alain.fresco@wavemind.ch', password: '123456', password_confirmation: '123456', role: role_administrator)
      algorithm = Algorithm.create!(name: 'ePoct', user: user)
      epoc_first = Version.create!(name: 'first_trial', algorithm: algorithm, user: user)
      @dd7 = Diagnostic.create!(version: epoc_first, label_en: 'Severe LRTI', reference: '7')
    end
  end

end
