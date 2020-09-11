class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: [:update_translations]

  def operators
    authorize policy_scope(Answer)
    render json: Answer.operators.map { |k, v| [I18n.t("answers.operators.#{k}"), k] }
  end

  # @params Answer with the translations
  # Update the object with its translation without
  def update_translations
    if @answer.update(answer_params)
      @json = { status: 'success', message: t('flash_message.success_updated')}
      render 'diagnostics/update_translations', formats: :js, status: :ok
    else
      @json = { status: 'alert', message: t('flash_message.update_fail')}
      render 'diagnostics/update_translations', formats: :js, status: :unprocessable_entity
    end
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
    authorize @answer
  end

  def answer_params
    params.require(:answer).permit(
      :id,
      :label_en,
      Language.label_params,
      :reference,
      :is_mandatory,
      :category,
      :answer_type_id,
    )
  end
end
