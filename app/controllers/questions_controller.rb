class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:edit, :update, :answers, :category_reference, :update_translations]
  before_action :set_algorithm, only: [:new, :create, :edit, :update, :answers]

  def new
    add_breadcrumb "#{@algorithm.name}", algorithm_url(@algorithm)

    @question = Question.new
  end

  def edit
    add_breadcrumb "#{@algorithm.name}", algorithm_url(@algorithm)
    add_breadcrumb "#{@question.label}", algorithms_question_url(@algorithm, @question)
  end

  def create
    @question = @algorithm.questions.new(question_params)

    if @question.save
      # Don't create answers if it is boolean type, since it is automatically created from the model
      if @question.answer_type.value == 'Boolean'
        redirect_to algorithm_url(@algorithm), notice: t('flash_message.success_created')
      else
        # Create a new first answer for the form view
        @question.answers << Answer.new
        # Clear the error messages to not have any validation errors before filling the form
        @question.answers.first.errors.clear

        render 'answers/new'
      end
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

  # PUT algorithm/:algorithm_id/version/:version_id/questions/:id/answers
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

  def update_translations
    if @question.update(question_params)
      flash.now[:notice] = t('flash_message.success_updated')
    else
      flash.now[:alert] = t('flash_message.update_fail')
    end

    respond_to do |format|
      format.html
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(
      :id,
      :label_en,
      :label_fr,
      :reference,
      :priority,
      :category_id,
      :description_en,
      :description_fr,
      :answer_type_id,
      answers_attributes: [
        :id,
        :reference,
        :label_en,
        :operator,
        :value,
        :_destroy
      ],
      medias_attributes: [
        :id,
        :label,
        :url,
        :fileable,
        :_destroy
      ]
    )
  end
end
