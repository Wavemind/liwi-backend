class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:edit, :update, :answers]
  before_action :set_algorithm, only: [:new, :create, :edit, :update, :answers]

  def new
    @question = Question.new
  end

  def edit

  end

  def create
    @question = Question.new(question_params)
    @question.algorithms << @algorithm

    if @question.save
      @question.answers << Answer.new
      render 'answers/new'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      render 'answers/edit'
    else
      render :edit
    end
  end

  # @params question [Question] object question contain multiple answers
  # @return redirect to algorithms#index with flash message
  # Create answers related to the current question
  def answers
    if @question.update(question_params)
      redirect_to algorithm_url(@algorithm), notice: t('flash_message.success_updated')
    else
      render 'answers/new'
    end
  end

  private

  def set_algorithm
    @algorithm = Algorithm.find(params[:algorithm_id])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(
      :id,
      :label,
      :reference,
      :priority,
      :category,
      :description,
      :answer_type_id,
      answers_attributes: [
        :id,
        :reference,
        :label,
        :operator,
        :value,
        :_destroy
      ]
    )
  end
end
