class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: [:edit, :update, :update_translations]
  before_action :set_question, only: [:new, :update]
  before_action :set_algorithm, only: [:new, :update]

  def new
    @answer = Answer.new
  end

  def update
    if @answer.update(answer_params)
      redirect_to algorithm_url(@algorithm, panel: 'questions'), notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  def operators
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

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
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
