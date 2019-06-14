class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:new, :create, :edit, :update, :answers, :destroy]
  before_action :set_breadcrumb, only: [:new, :edit]
  before_action :set_question, only: [:edit, :update, :answers, :category_reference, :update_translations, :destroy]

  def new
    add_breadcrumb t('breadcrumbs.new')

    @question = Question.new
    @question.type = nil
  end

  def edit
    add_breadcrumb @question.label
    add_breadcrumb t('breadcrumbs.edit')
  end

  def create
    @question = @algorithm.questions.new(question_params)
    puts '***'
    puts question_params
    puts '***'
    puts @question.inspect
    puts '***'

    if @question.save
      # Don't create answers if it is boolean type, since it is automatically created from the model
      if @question.answer_type.value == 'Boolean'
        redirect_to algorithm_url(@algorithm, panel: 'questions'), notice: t('flash_message.success_created')
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

  def destroy
    # If user remove 'disabled' css in button, we verify in controller
    if @question.dependencies?
      redirect_to algorithm_url(@algorithm, panel: 'questions'), alert: t('dependencies')
    else
      if @question.destroy
        redirect_to algorithm_url(@algorithm, panel: 'questions'), notice: t('flash_message.success_updated')
      else
        redirect_to algorithm_url(@algorithm, panel: 'questions'), alert: t('error')
      end
    end
  end

  # PUT algorithm/:algorithm_id/version/:version_id/questions/:id/answers
  # @params question [Question] object question contain multiple answers
  # @return redirect to algorithms#index with flash message
  # Create answers related to the current question
  def answers
    if @question.update(question_params)
      redirect_to algorithm_url(@algorithm, panel: 'questions'), notice: t('flash_message.success_updated')
    else
      render 'answers/new'
    end
  end

  def reference_prefix
    render json: Question.reference_prefix_class(params[:type])
  end

  # @params Question with the translations
  # Update the object with its translation without
  def update_translations
    if @question.update(question_params)
      @json = { status: 'success', message: t('flash_message.success_updated') }
      render 'diagnostics/update_translations', formats: :js, status: :ok
    else
      @json = { status: 'alert', message: t('flash_message.update_fail') }
      render 'diagnostics/update_translations', formats: :js, status: :unprocessable_entity
    end
  end

  private

  def set_breadcrumb
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm, panel: 'questions')
    add_breadcrumb t('breadcrumbs.questions')
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(
      :id,
      :label_en,
      Language.label_params,
      :reference,
      :priority,
      :type,
      :description_en,
      Language.description_params,
      :answer_type_id,
      :unavailable,
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
