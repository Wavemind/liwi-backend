class AnswersController < ApplicationController
  before_action :authenticate_user!

  # GET answers/operators
  # Return array of operators for react to create dropdown list
  def operators
    authorize policy_scope(Answer)
    render json: Answer.operators.map { |k, v| [I18n.t("answers.operators.#{k}"), k] }
  end

  private

  def answer_params
    params.require(:answer).permit(
      :id,
      :label_en,
      Language.language_params('label'),
      :reference,
      :is_mandatory,
      :category,
      :answer_type_id,
    )
  end
end
