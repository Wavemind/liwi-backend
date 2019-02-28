module ServiceMacros

  def create_full_algorithm_version
    before(:each) do
      role_administrator = Role.create!(name: 'Administrator')
      emmanuel = User.create!(first_name: 'Emmanuel', last_name: 'Barchichat', email: 'emmanuel.barchichat@wavemind.ch', password: '123456', password_confirmation: '123456', role: role_administrator)
      epoct = Algorithm.create!(name: 'ePoct', description: 'loremp ipsum', user: emmanuel)
      epoc_first = Version.create!(name: 'first_trial', algorithm: epoct, user: emmanuel)

      # Answer types
      radio = AnswerType.create!(value: 'Array', display: 'Radiobutton')
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

      s2 = Question.create!(algorithm: epoct, label: 'Cough', reference: '2', category: symptom, priority: Question.priorities[:priority], answer_type: radio)
      s2_1 = Answer.create!(node: s2, reference: '1', label: 'yes', value: nil, operator: nil)
      s2_2 = Answer.create!(node: s2, reference: '2', label: 'no', value: nil, operator: nil)

      s4 = Question.create!(algorithm: epoct, label: 'Drink as usual', reference: '4', category: symptom, priority: Question.priorities[:priority], answer_type: radio)
      s4_1 = Answer.create!(node: s4, reference: '1', label: 'yes', value: nil, operator: nil)
      s4_2 = Answer.create!(node: s4, reference: '2', label: 'no', value: nil, operator: nil)

      p1 = Question.create!(algorithm: epoct, label: 'SAO2', reference: '1', category: physical_exam, priority: Question.priorities[:triage], answer_type: input_integer)
      p1_1 = Answer.create!(node: p1, reference: '1', label: '>/= 90%', value: '90', operator: '>=')
      p1_1 = Answer.create!(node: p1, reference: '2', label: '< 90%', value: '90', operator: '<')

      p3 = Question.create!(algorithm: epoct, label: 'Respiratory rate', reference: '3', category: physical_exam, priority: Question.priorities[:triage], answer_type: input_integer)
      p3_1 = Answer.create!(node: p3, reference: '1', label: '< 97th%ile', value: '97', operator: '<')
      p3_2 = Answer.create!(node: p3, reference: '2', label: '>/= 97th%ile', value: '97', operator: '>=')

      p13 = Question.create!(algorithm: epoct, label: 'Lower chest indrawing', reference: '13', category: physical_exam, priority: Question.priorities[:basic], answer_type: radio)
      p13_1 = Answer.create!(node: p13, reference: '1', label: 'yes', value: nil, operator: nil)
      p13_2 = Answer.create!(node: p13, reference: '2', label: 'no', value: nil, operator: nil)


      p14 = Question.create!(algorithm: epoct, label: 'Sever respiratory distress', reference: '14', category: physical_exam, priority: Question.priorities[:basic], answer_type: radio)
      p14_1 = Answer.create!(node: p14, reference: '1', label: 'yes', value: nil, operator: nil)
      p14_1 = Answer.create!(node: p14, reference: '2', label: 'no', value: nil, operator: nil)

      p25 = Question.create!(algorithm: epoct, label: 'Tolerates PO liquid', reference: '25', category: physical_exam, priority: Question.priorities[:basic], answer_type: radio)
      p25_1 = Answer.create!(node: p25, reference: '1', label: 'yes', value: nil, operator: nil)
      p25_2 = Answer.create!(node: p25, reference: '2', label: 'no', value: nil, operator: nil)

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
