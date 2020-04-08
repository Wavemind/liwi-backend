class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:new, :create, :edit, :update, :destroy, :validate, :lists]
  before_action :set_breadcrumb, only: [:new, :edit]
  before_action :set_question, only: [:edit, :update, :category_reference, :update_translations, :destroy]

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
    ActiveRecord::Base.transaction(requires_new: true) do
      question = @algorithm.questions.new(question_params)

      question.becomes(Object.const_get(question_params[:type])) if question_params[:type].present?
      question.unavailable = question_params[:unavailable] if question.is_a? Questions::AssessmentTest # Manually done it because the form could not handle it

      question.answers.map { |f| f.node = question } # No idea Why we have to do this

      # in order to add answers after creation (which can't be done if the question has no id), we also remove reference from params so it will not fail validation
      if question.validate_overlap && question.save
        if params[:from] == 'rails'
          render json: {url: algorithm_url(@algorithm, panel: 'questions')}
        else
          instanceable = Object.const_get(params[:instanceable_type].camelize.singularize).find(params[:instanceable_id])
          instance = instanceable.components.create!(node: question, final_diagnostic_id: params[:final_diagnostic_id])
          render json: instance.generate_json
        end
      else
        render json: question.errors.full_messages, status: 422
        raise ActiveRecord::Rollback, ''
      end
    end
  end

  def update
    ActiveRecord::Base.transaction(requires_new: true) do
      if @question.update(question_params) && @question.validate_overlap
        if params[:from] == 'rails'
          render json: {url: algorithm_url(@algorithm, panel: 'questions')}
        else
          render json: @question.as_json(include: [:answers, :complaint_categories], methods: [:node_type, :category_name, :type])
        end

      else
        render json: question.errors.full_messages, status: 422
        raise ActiveRecord::Rollback, ''
      end
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

  # GET
  # @return Hash
  # Return attributes of question that are listed
  def lists
    render json: Question.list_attributes(params[:diagram_type], @algorithm)
  end

  # GET algorithm/:algorithm_id/version/:version_id/questions/reference_prefix/:type
  # @params Question child
  # @return json with the reference prefix of the child
  def reference_prefix
    render json: Question.reference_prefix_class(params[:type])
  end

  # POST algorithm/:algorithm_id/questions/validate
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
      :answer_type,
      :unavailable,
      :formula,
      :formula,
      :snomed_id,
      :snomed_label,
      :is_triage,
      :is_identifiable,
      complaint_category_ids: [],
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
