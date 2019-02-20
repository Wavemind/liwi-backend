require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  login_user

  it 'returns the right prefix' do
    category = Category.create!(reference_prefix: 'S', name_en: 'Symptom')

    get :reference, params: {id: category.id}
    expect(response.body).to eq('S')
  end

end
