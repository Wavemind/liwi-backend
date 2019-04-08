module ModelMacros
  def create_algorithm
    before(:each) do
      Language.create!(name: 'French', code: 'fr')
      role_administrator = Role.create!(name: 'Administrator')
      @user = User.create!(first_name: 'Alain', last_name: 'Fresco', email: 'alain.fresco@wavemind.ch', password: '123456', password_confirmation: '123456', role: role_administrator)
      @algorithm = Algorithm.create!(name: 'ePoct', user: @user)
    end
  end

  def create_version
    before(:each) do
      role_administrator = Role.create!(name: 'Administrator')
      user = User.create!(first_name: 'Alain', last_name: 'Fresco', email: 'alain.fresco@wavemind.ch', password: '123456', password_confirmation: '123456', role: role_administrator)
      algorithm = Algorithm.create!(name: 'ePoct', user: user)
      @version = Version.create!(name: 'first_trial', algorithm: algorithm, user: user)
    end
  end

  def create_answer_type
    before(:each) do
      @input_integer = AnswerType.create!(value: 'Integer', display: 'Input')
      @boolean = AnswerType.create!(value: 'Boolean', display: 'RadioButton')
    end
  end

  def create_category
    before(:each) do
      @physical_exam = Category.create!(name_en: 'Physical exam', reference_prefix: 'P')
      @symptom = Category.create!(name_en: 'Symptom', reference_prefix: 'S')
    end
  end

  def create_diagnostic
    before(:each) do
      epoc_first = Version.create!(name: 'first_trial', algorithm: @algorithm, user: @user)
      @dd7 = Diagnostic.create!(version: epoc_first, label_en: 'Severe LRTI', reference: '7')
    end
  end

  def create_question
    before(:each) do
      symptom = Category.create!(name_en: 'Symptom', reference_prefix: 'S', parent: 'Question')
      boolean = AnswerType.create!(value: 'Boolean', display: 'RadioButton')
      @question = Question.create!(algorithm: @algorithm, label_en: 'Cough', reference: '2456', category: symptom, priority: Question.priorities[:mandatory], answer_type: boolean)
    end
  end

  def create_predefined_syndrome_category
    before(:each) do
      @ps_category = Category.create!(reference_prefix: 'PS', name_en: 'Predefined syndrome', parent: 'PredefinedSyndrome')
    end
  end

  def create_instances
    before(:each) do
      # Version
      epoc_first = Version.create!(name: 'first_trial', algorithm: @algorithm, user: @user)

      # Questions
      s2 = Question.create!(algorithm: @algorithm, label_en: 'Cough', reference: '2123123', category: @symptom, priority: Question.priorities[:mandatory], answer_type: @boolean)
      p13 = Question.create!(algorithm: @algorithm, label_en: 'Lower chest indrawing', reference: '1331231231', category: @physical_exam, priority: Question.priorities[:basic], answer_type: @boolean)
      p3 = Question.create!(algorithm: @algorithm, label_en: 'Respiratory rate', reference: '34123123', category: @physical_exam, priority: Question.priorities[:triage], answer_type: @input_integer)
      p1 = Question.create!(algorithm: @algorithm, label_en: 'SAO2', reference: '1123123', category: @physical_exam, priority: Question.priorities[:triage], answer_type: @input_integer)

      # Answers
      @s2_1 = s2.answers.first
      @p3_2 = Answer.create!(node: p3, reference: '2', label_en: '>/= 97th%ile', value: '97', operator: Answer.operators[:more_or_equal])
      @p13_1 = p13.answers.first

      # Diagnostics
      @dd7 = Diagnostic.create!(version: epoc_first, label_en: 'Severe LRTI', reference: '7')
      df7 = FinalDiagnostic.create!(label_en: 'Severe lower respiratory tract infection', reference: '7', diagnostic: @dd7)

      # Instances
      @dd7_p1 = Instance.create!(instanceable: @dd7, node: p1)
      @dd7_df7 = Instance.create!(instanceable: @dd7, node: df7)

      # PS
      ps_category = Category.create!(reference_prefix: 'PS', name_en: 'Predefined syndrome', parent: 'PredefinedSyndrome')
      ps6 = PredefinedSyndrome.create!(algorithm: @algorithm, reference: '6', label_en: 'Able to drink', category: ps_category)

      # Children
      Child.create!(instance: @dd7_p1, node: df7)
      Child.create!(instance: @dd7_df7, node: ps6)
    end
  end

end
