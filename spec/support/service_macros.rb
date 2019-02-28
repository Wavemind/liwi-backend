module ServiceMacros

  def create_full_algorithm_version
    before(:each) do
      role_administrator = Role.create!(name: 'Administrator')
      emmanuel = User.create!(first_name: 'Emmanuel', last_name: 'Barchichat', email: 'emmanuel.barchichat@wavemind.ch', password: '123456', password_confirmation: '123456', role: role_administrator)
      epoct = Algorithm.create!(name: 'ePoct', description: 'loremp ipsum', user: emmanuel)
      epoc_first = Version.create!(name: 'first_trial', algorithm: epoct, user: emmanuel)

      # Answer types
      boolean = AnswerType.create!(value: 'Boolean', display: 'RadioButton')
      checkbox = AnswerType.create!(value: 'Array', display: 'Checkbox')
      input_integer = AnswerType.create!(value: 'Integer', display: 'Input')
      input_float = AnswerType.create!(value: 'Float', display: 'Input')

      # Categories
      exposure = Category.create!(name_en: 'Exposure', reference_prefix: 'E', parent: 'Question')
      symptom = Category.create!(name_en: 'Symptom', reference_prefix: 'S', parent: 'Question')
      assessement_text = Category.create!(name_en: 'Assessment/Test', reference_prefix: 'A', parent: 'Question')
      physical_exam = Category.create!(name_en: 'Physical exam', reference_prefix: 'P', parent: 'Question')

      predefined_syndrome = Category.create!(name_en: 'Predefined syndrome', reference_prefix: 'PS', parent: 'PredefinedSyndrome')
      comorbidity = Category.create!(name_en: 'Comorbidity', reference_prefix: 'DC', parent: 'PredefinedSyndrome')
      predefined_condition = Category.create!(name_en: 'Predefined condition', reference_prefix: 'C', parent: 'PredefinedSyndrome')

      dd7 = Diagnostic.create!(version: epoc_first, label: 'Severe LRTI', reference: '7')
      df7 = FinalDiagnostic.create!(label: 'Severe lower respiratory tract infection', reference: '7', diagnostic: dd7)

      s2 = Question.create!(algorithm: epoct, label: 'Cough', reference: '2', category: symptom, priority: Question.priorities[:priority], answer_type: boolean)
      s2_1 = s2.answers.first
      s2_2 = s2.answers.second

      s4 = Question.create!(algorithm: epoct, label: 'Drink as usual', reference: '4', category: symptom, priority: Question.priorities[:priority], answer_type: boolean)
      s4_1 = s4.answers.first
      s4_2 = s4.answers.second

      p1 = Question.create!(algorithm: epoct, label: 'SAO2', reference: '1', category: physical_exam, priority: Question.priorities[:triage], answer_type: input_integer)
      p1_1 = Answer.create!(node: p1, reference: '1', label: '>/= 90%', value: '90', operator: Answer.operators[:more_or_equal])
      p1_1 = Answer.create!(node: p1, reference: '2', label: '< 90%', value: '90', operator: Answer.operators[:less])

      p3 = Question.create!(algorithm: epoct, label: 'Respiratory rate', reference: '3', category: physical_exam, priority: Question.priorities[:triage], answer_type: input_integer)
      p3_1 = Answer.create!(node: p3, reference: '1', label: '< 97th%ile', value: '97', operator: Answer.operators[:less])
      p3_2 = Answer.create!(node: p3, reference: '2', label: '>/= 97th%ile', value: '97', operator: Answer.operators[:more_or_equal])

      p13 = Question.create!(algorithm: epoct, label: 'Lower chest indrawing', reference: '13', category: physical_exam, priority: Question.priorities[:basic], answer_type: boolean)
      p13_1 = p13.answers.first
      p13_2 = p13.answers.second


      p14 = Question.create!(algorithm: epoct, label: 'Sever respiratory distress', reference: '14', category: physical_exam, priority: Question.priorities[:basic], answer_type: boolean)
      p14_1 = p14.answers.first
      p14_1 = p14.answers.second

      p25 = Question.create!(algorithm: epoct, label: 'Tolerates PO liquid', reference: '25', category: physical_exam, priority: Question.priorities[:basic], answer_type: boolean)
      p25_1 = p25.answers.first
      p25_2 = p25.answers.second

      t1 = Treatment.create!(algorithm: epoct, label: 'Amoxicillin', reference: '1')
      t2 = Treatment.create!(algorithm: epoct, label: 'IM ceftriaxone', reference: '2')
      t9 = Treatment.create!(algorithm: epoct, label: 'Oral rehydration', reference: '9')

      m2 = Management.create!(algorithm: epoct, label: 'Refer', reference: '2')

      df7.nodes << [t1,t2,t9, m2]

      ps6 = PredefinedSyndrome.create!(algorithm: epoct, reference: '6', label: 'Able to drink', category: predefined_syndrome)
      ps6_1 = ps6.answers.first
      ps6_2 = ps6.answers.second

      # DF7
      dd7_s2 = Instance.create!(instanceable: dd7, node: s2)
      dd7_p3 = Instance.create!(instanceable: dd7, node: p3)
      dd7_p13 = Instance.create!(instanceable: dd7, node: p13)
      dd7_p14 = Instance.create!(instanceable: dd7, node: p14)
      dd7_p1 = Instance.create!(instanceable: dd7, node: p1)
      dd7_df7 = Instance.create!(instanceable: dd7, node: df7)
      dd7_ps6 = Instance.create!(instanceable: dd7, node: ps6)
      dd7_t9 = Instance.create!(instanceable: dd7, node: t9)
      dd7_t1 = Instance.create!(instanceable: dd7, node: t1)
      dd7_t2 = Instance.create!(instanceable: dd7, node: t2)
      dd7_m2 = Instance.create!(instanceable: dd7, node: m2)

      # PS6
      ps6_s4 = Instance.create!(instanceable: ps6, node: s4)
      ps6_p25 = Instance.create!(instanceable: ps6, node: p25)
      ps6_ps6 = Instance.create!(instanceable: ps6, node: ps6)


      Child.create!(instance: ps6_s4, node: ps6)
      Child.create!(instance: ps6_s4, node: p25)
      Child.create!(instance: ps6_p25, node: ps6)

      Child.create!(instance: dd7_s2, node: p14)
      Child.create!(instance: dd7_s2, node: p13)
      Child.create!(instance: dd7_s2, node: p1)
      Child.create!(instance: dd7_s2, node: p3)

      Child.create!(instance: dd7_p14, node: df7)
      Child.create!(instance: dd7_p1, node: df7)
      Child.create!(instance: dd7_p3, node: df7)
      Child.create!(instance: dd7_p13, node: df7)

      Child.create!(instance: dd7_df7, node: ps6)

      Child.create!(instance: dd7_ps6, node: t9)
      Child.create!(instance: dd7_ps6, node: t1)
      Child.create!(instance: dd7_ps6, node: t2)


      Condition.create!(referenceable: ps6_p25, first_conditionable: s4_2, operator: nil, second_conditionable: nil)
      Condition.create!(referenceable: ps6_ps6, first_conditionable: s4_1, operator: nil, second_conditionable: nil)
      Condition.create!(referenceable: ps6_ps6, first_conditionable: p25_1, operator: nil, second_conditionable: nil)

      Condition.create!(referenceable: dd7_p1, first_conditionable: s2_1, operator: nil, second_conditionable: nil)
      Condition.create!(referenceable: dd7_p3, first_conditionable: s2_1, operator: nil, second_conditionable: nil)
      Condition.create!(referenceable: dd7_p13, first_conditionable: s2_1, operator: nil, second_conditionable: nil)
      Condition.create!(referenceable: dd7_p14, first_conditionable: s2_1, operator: nil, second_conditionable: nil)

      Condition.create!(referenceable: dd7_df7, first_conditionable: p14_1, operator: nil, second_conditionable: nil)
      Condition.create!(referenceable: dd7_df7, first_conditionable: p3_2, operator: Condition.operators[:and_operator], second_conditionable: p13_1)
      Condition.create!(referenceable: dd7_df7, first_conditionable: p1_1, operator: nil, second_conditionable: nil)

      Condition.create!(referenceable: dd7_ps6, first_conditionable: df7, operator: nil, second_conditionable: nil)
      Condition.create!(referenceable: dd7_t9, first_conditionable: ps6_1, operator: nil, second_conditionable: nil)
      Condition.create!(referenceable: dd7_t1, first_conditionable: ps6_1, operator: nil, second_conditionable: nil)
      Condition.create!(referenceable: dd7_t2, first_conditionable: ps6_2, operator: nil, second_conditionable: nil)
      Condition.create!(referenceable: dd7_m2, first_conditionable: ps6_2, operator: nil, second_conditionable: ps6_1)

      @json = VersionsService.generate_hash(Version.first.id)
    end
  end

end
