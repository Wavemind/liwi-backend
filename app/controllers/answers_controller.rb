class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: [:edit, :update, :update_translations]
  before_action :set_question, only: [:new, :create, :edit, :update]
  before_action :set_algorithm, only: [:new, :create, :edit, :update]


  def new
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.algorithms << @algorithm

    if @answer.save
      redirect_to new_algorithm_answer_answer_url(@algorithm, @answer)
    else
      render :new
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to algorithm_url(@algorithm), notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  def update_translations
    if @answer.update(answer_params)
      @json = { status: 'success', message: t('flash_message.success_updated')}
    else
      @json = { status: 'alert', message: t('flash_message.update_fail')}
    end

    render 'update_translations', formats: :js
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
      :label_fr,
      :reference,
      :priority,
      :category,
      :description_en,
      :answer_type_id,
    )
  end
end
