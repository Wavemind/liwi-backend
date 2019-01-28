module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      role = Role.create(name: 'administrator')
      user = User.create(first_name: 'Foo', last_name: 'Bar', email: 'foo.bar@ilovetestunit.com', password: '123456', password_confirmation: '123456', role: role)
      sign_in user
    end
  end
end
