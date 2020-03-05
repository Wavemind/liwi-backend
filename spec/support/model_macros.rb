module ModelMacros

  def create_algorithm
    before(:each) do
      Language.create!(name: 'French', code: 'fr')
      @user = User.create!(first_name: 'Alain', last_name: 'Fresco', email: 'alain.fresco@wavemind.ch', password: '123456', password_confirmation: '123456')
      @algorithm = Algorithm.create!(name: 'ePoct', user: @user)
    end
  end

  def create_version
    before(:each) do
      user = User.create!(first_name: 'Alain', last_name: 'Fresco', email: 'manu.barchichat@wavemind.ch', password: '123456', password_confirmation: '123456')
      algorithm = Algorithm.create!(name: 'Liwi', user: user)
      @version = Version.create!(name: 'first_trial', algorithm: algorithm, user: user)
    end
  end

  def create_answer_type
    before(:each) do
      @boolean = AnswerType.create!(value: 'Boolean', display: 'RadioButton')
      @dropdown_list = AnswerType.create!(value: 'Array', display: 'DropDownList')
      @input_integer = AnswerType.create!(value: 'Integer', display: 'Input')
      @input_float = AnswerType.create!(value: 'Float', display: 'Input')
      @formula = AnswerType.create!(value: 'Float', display: 'Formula')
      @date = AnswerType.create!(value: 'Date', display: 'Input')
      @present_absent = AnswerType.create!(value: 'Present', display: 'DropDownList')
      @positive_negative = AnswerType.create!(value: 'Positive', display: 'DropDownList')
    end
  end

  def create_diagnostic
    before(:each) do
      epoc_first = Version.create!(name: 'first_trial', algorithm: @algorithm, user: @user)
      boolean = AnswerType.create!(value: 'Boolean', display: 'RadioButton')
      @cc = @algorithm.questions.create!(answer_type: boolean, label_en: 'CC11', stage: Question.stages[:triage], type: 'Questions::ComplaintCategory')
      @dd7 = Diagnostic.create!(version: epoc_first, label_en: 'Severe LRTI', node: @cc)
    end
  end

  def create_question
    before(:each) do
      @boolean = AnswerType.create!(value: 'Boolean', display: 'RadioButton')
      @question = Questions::Symptom.create!(algorithm: @algorithm, label_en: 'Cough', stage: Question.stages[:triage], answer_type: @boolean)
    end
  end

  def create_instances
    before(:each) do
      # Version
      epoc_first = Version.create!(name: 'first_trial', algorithm: @algorithm, user: @user)

      # Questions
      s2 = Questions::Symptom.create!(algorithm: @algorithm, label_en: 'Cough', stage: Question.stages[:triage], answer_type: @boolean)
      p13 = Questions::PhysicalExam.create!(algorithm: @algorithm, label_en: 'Lower chest indrawing', stage: Question.stages[:triage], answer_type: @boolean)
      p3 = Questions::PhysicalExam.create!(algorithm: @algorithm, label_en: 'Respiratory rate', stage: Question.stages[:triage], answer_type: @input_integer)
      @p1 = Questions::PhysicalExam.create!(algorithm: @algorithm, label_en: 'SAO2', stage: Question.stages[:triage], answer_type: @input_integer)
      @cc = @algorithm.questions.create!(answer_type: @boolean, label_en: 'CC11', stage: Question.stages[:triage], type: 'Questions::ComplaintCategory')

      # Answers
      @s2_1 = s2.answers.first
      @p1_1 = Answer.create!(node: @p1, label_en: '>/= 90%', value: '90', operator: Answer.operators[:more_or_equal])
      @p3_2 = Answer.create!(node: p3, label_en: '>/= 97th%ile', value: '97', operator: Answer.operators[:more_or_equal])
      @p13_1 = p13.answers.first

      # Diagnostics
      @dd7 = Diagnostic.create!(version: epoc_first, label_en: 'Severe LRTI', node: @cc)
      @df7 = FinalDiagnostic.create!(label_en: 'Severe lower respiratory tract infection', diagnostic: @dd7)

      # Instances
      @dd7_p1 = Instance.create!(instanceable: @dd7, node: @p1)
      @dd7_p3 = Instance.create!(instanceable: @dd7, node: p3)
      @dd7_p13 = Instance.create!(instanceable: @dd7, node: p13)
      @dd7_s2 = Instance.create!(instanceable: @dd7, node: s2)
      @dd7_df7 = Instance.create!(instanceable: @dd7, node: @df7)

      # Conditions
      @cond1 = Condition.create!(referenceable: @dd7_df7, first_conditionable: @p3_2, top_level: true)

      # PS
      @ps6 = QuestionsSequences::PredefinedSyndrome.create!(algorithm: @algorithm, reference: '6', label_en: 'Able to drink')

      # Management
      @management = HealthCares::Management.create!(algorithm: @algorithm, reference: '11', label_en: 'Hospital')

      # Final diagnostic health care
      @dfh7 = FinalDiagnosticHealthCare.create!(node_id: @management.id, final_diagnostic: @df7)
    end
  end

end
