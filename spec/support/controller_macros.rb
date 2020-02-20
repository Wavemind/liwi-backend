module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = User.create(first_name: 'Foo', last_name: 'Bar', email: 'foo.bar@ilovetestunit.com', password: '123456', password_confirmation: '123456')
      sign_in user
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
end
