require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  login_user
  create_answer_type
  create_algorithm
  create_question

end
