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
      user = User.create!(first_name: 'Alain', last_name: 'Fresco', email: 'manu.barchichat@wavemind.ch', password: '123456', password_confirmation: '123456', role: role_administrator)
      algorithm = Algorithm.create!(name: 'Liwi', user: user)
      @version = Version.create!(name: 'first_trial', algorithm: algorithm, user: user)
    end
  end

  def create_answer_type
    before(:each) do
      @input_integer = AnswerType.create!(value: 'Integer', display: 'Input')
      @input_float = AnswerType.create!(value: 'Float', display: 'Float')
      @boolean = AnswerType.create!(value: 'Boolean', display: 'RadioButton')
    end
  end

  def create_diagnostic
    before(:each) do
      epoc_first = Version.create!(name: 'first_trial', algorithm: @algorithm, user: @user)
      boolean = AnswerType.create!(value: 'Boolean', display: 'RadioButton')
      @cc = @algorithm.questions.create!(reference: '11', answer_type: boolean, label_en: 'CC11', stage: Question.stages[:triage], priority: Question.priorities[:mandatory], type: 'Questions::ChiefComplaint')
      @dd7 = Diagnostic.create!(version: epoc_first, label_en: 'Severe LRTI', reference: '7', node: @cc)
    end
  end

  def create_question
    before(:each) do
      @boolean = AnswerType.create!(value: 'Boolean', display: 'RadioButton')
      @question = Questions::Symptom.create!(algorithm: @algorithm, label_en: 'Cough', reference: '2456', priority: Question.priorities[:mandatory], stage: Question.stages[:triage], answer_type: @boolean)
    end
  end

  def create_instances
    before(:each) do
      # Version
      epoc_first = Version.create!(name: 'first_trial', algorithm: @algorithm, user: @user)

      # Questions
      s2 = Questions::Symptom.create!(algorithm: @algorithm, label_en: 'Cough', reference: '2123123', priority: Question.priorities[:mandatory], stage: Question.stages[:triage], answer_type: @boolean)
      p13 = Questions::PhysicalExam.create!(algorithm: @algorithm, label_en: 'Lower chest indrawing', reference: '1331231231', priority: Question.priorities[:basic], stage: Question.stages[:triage], answer_type: @boolean)
      p3 = Questions::PhysicalExam.create!(algorithm: @algorithm, label_en: 'Respiratory rate', reference: '34123123', priority: Question.priorities[:mandatory], stage: Question.stages[:triage], answer_type: @input_integer)
      @p1 = Questions::PhysicalExam.create!(algorithm: @algorithm, label_en: 'SAO2', reference: '1123123', priority: Question.priorities[:mandatory], stage: Question.stages[:triage], answer_type: @input_integer)
      @cc = @algorithm.questions.create!(reference: '11', answer_type: @boolean, label_en: 'CC11', stage: Question.stages[:triage], priority: Question.priorities[:mandatory], type: 'Questions::ChiefComplaint')

      # Answers
      @s2_1 = s2.answers.first
      @p1_1 = Answer.create!(node: @p1, reference: '1', label_en: '>/= 90%', value: '90', operator: Answer.operators[:more_or_equal])
      @p3_2 = Answer.create!(node: p3, reference: '2', label_en: '>/= 97th%ile', value: '97', operator: Answer.operators[:more_or_equal])
      @p13_1 = p13.answers.first

      # Diagnostics
      @dd7 = Diagnostic.create!(version: epoc_first, label_en: 'Severe LRTI', reference: '7', node: @cc)
      @df7 = FinalDiagnostic.create!(label_en: 'Severe lower respiratory tract infection', reference: '7', diagnostic: @dd7)

      # Instances
      @dd7_p1 = Instance.create!(instanceable: @dd7, node: @p1)
      @dd7_p3 = Instance.create!(instanceable: @dd7, node: p3)
      @dd7_p13 = Instance.create!(instanceable: @dd7, node: p13)
      @dd7_s2 = Instance.create!(instanceable: @dd7, node: s2)
      @dd7_df7 = Instance.create!(instanceable: @dd7, node: @df7)

      # Conditions
      @cond1 = Condition.create!(referenceable: @dd7_df7, first_conditionable: @p3_2, top_level: true)

      # PS
      ps6 = QuestionsSequences::PredefinedSyndrome.create!(algorithm: @algorithm, reference: '6', label_en: 'Able to drink')
    end
  end

end
