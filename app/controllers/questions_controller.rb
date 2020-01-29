class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:new, :create, :edit, :update, :answers, :destroy, :create_from_diagram, :validate]
  before_action :set_breadcrumb, only: [:new, :edit]
  before_action :set_question, only: [:edit, :update, :answers, :category_reference, :update_translations, :destroy, :update_from_diagram]

  def new
    add_breadcrumb t('breadcrumbs.new')

    @question = Question.new
    @question.type = nil # To resolve issue that prevents to display the prompt in the form
  end

  def edit
    add_breadcrumb @question.label
    add_breadcrumb t('breadcrumbs.edit')
  end

  def create
    @question = @algorithm.questions.new(question_params)

    if @question.save
      # Don't create answers if it is boolean type, since it is automatically created from the model
      if %w(Boolean Present Positive).include?(@question.answer_type.value) || @question.is_a?(Questions::VitalSignTriage) || @question.is_a?(Questions::VitalSignConsultation)
        redirect_to algorithm_url(@algorithm, panel: 'questions'), notice: t('flash_message.success_created')
      else
        # Create a new first answer for the form view
        @question.answers.new
        # Clear the error messages to not have any validation errors before filling the form
        @question.answers.first.errors.clear
        render 'answers/new'
      end
    else
      set_breadcrumb
      add_breadcrumb t('breadcrumbs.new')

      render :new
    end
  end

  def update
    if @question.update(question_params)
      if @question.answer_type.value == 'Boolean'
        redirect_to algorithm_url(@algorithm, panel: 'questions'), notice: t('flash_message.success_updated')
      else
        render 'answers/edit'
      end
    else
      set_breadcrumb
      add_breadcrumb t('breadcrumbs.edit')

      render :edit
    end
  end

  def destroy
    # If user remove 'disabled' css in button, we verify in controller
    if @question.instance_dependencies?
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
    ActiveRecord::Base.transaction(requires_new: true) do
      @question.answers.reload

      if @question.update(question_params) && @question.validate_overlap
        redirect_to algorithm_url(@algorithm, panel: 'questions'), notice: t('flash_message.success_updated')
      else
        flash[:alert] = @question.errors[:answers] if @question.errors[:answers].any?

        # Code to reassign corrects id to failing answers that failed after a validation fail. On wait for improvements
        i = 0
        question_params[:answers_attributes].each_pair do |key, value|
          @question.answers[i].id = value[:id]
          i+=1
        end

        render 'answers/new'
        raise ActiveRecord::Rollback, ''
      end
    end
  end

  # POST
  # @return  node
  # Create a question node from diagram and instance it
  def create_from_diagram
    ActiveRecord::Base.transaction(requires_new: true) do
      question = @algorithm.questions.new(question_params).becomes(Object.const_get(question_params[:type]))
      question.becomes(Object.const_get(question_params[:type])) if question_params[:type].present?

      question.unavailable = question_params[:unavailable] if question.is_a? Questions::AssessmentTest # Manually done it because the form could not handle it

      # in order to add answers after creation (which can't be done if the question has no id), we also remove reference from params so it will not fail validation
      if question.save && question.update(question_params.except(:reference)) && question.validate_overlap
        instanceable = Object.const_get(params[:instanceable_type].camelize.singularize).find(params[:instanceable_id])
        instanceable.components.create!(node: question, final_diagnostic_id: params[:final_diagnostic_id])
        render json: {status: 'success', messages: [t('flash_message.success_created')], node: question.as_json(include: :answers, methods: [:node_type, :category_name, :type])}
      else
        errors = (question.answer_type.value == 'Boolean') ? question.errors.messages : question.answers.map(&:errors).map(&:messages)
        render json: {status: 'danger', errors: errors, overlap_errors: question.errors[:answers], ok: false}
        raise ActiveRecord::Rollback, ''
      end
    end
  end

  # GET algorithm/:algorithm_id/version/:version_id/questions/reference_prefix/:type
  # @params Question child
  # @return json with the reference prefix of the child
  def reference_prefix
    render json: Question.reference_prefix_class(params[:type])
  end

  # PUT
  # @return questions_sequence node
  # Update a questions sequence node from diagram
  def update_from_diagram
    ActiveRecord::Base.transaction(requires_new: true) do
      if @question.update(question_params) && @question.validate_answers_references && @question.validate_overlap
        render json: {status: 'success', messages: [t('flash_message.success_updated')], node: @question.as_json(include: :answers, methods: [:category_name, :node_type, :type])}
      else
        errors = (@question.answer_type.value == 'Boolean') ? @question.errors.messages : @question.answers.map(&:errors).map(&:messages)
        render json: {status: 'danger', errors: errors, overlap_errors: @question.errors[:answers], ok: false}
        raise ActiveRecord::Rollback, ''
      end
    end
  end

  # GET algorithm/:algorithm_id/questions/validate
  # @params Question
  # @return errors messages if question is not valid
  def validate
    question = @algorithm.questions.new(question_params)
    if question.valid?
      render json: {status: 'success', messages: ['valid']}
    else
      render json: {status: 'danger', errors: question.errors.messages, ok: false}
    end
  end

  # @params Question with the translations
  # Update the object with its translation without rendering a new page
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
    @question = Node.find(params[:id])
  end

  def question_params
    params.require(:question).permit(
      :id,
      :label_en,
      Language.label_params,
      :reference,
      :is_mandatory,
      :system,
      :stage,
      :type,
      :description_en,
      Language.description_params,
      :answer_type_id,
      :unavailable,
      :formula,
      :snomed_id,
      :snomed_label,
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
        :label_en,
        :url,
        :fileable,
        :_destroy
      ]
    )
  end
end
