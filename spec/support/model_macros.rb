module ModelMacros
  def create_algorithm
    before(:each) do
      role_administrator = Role.create!(name: 'Administrator')
      @user = User.create!(first_name: 'Alain', last_name: 'Fresco', email: 'alain.fresco@wavemind.ch', password: '123456', password_confirmation: '123456', role: role_administrator)
      @algorithm = Algorithm.create!(name: 'ePoct', user: @user)
    end
  end
end
