class QuestionsSequencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:new, :create, :edit, :update, :destroy, :lists]
  before_action :set_questions_sequence, only: [:edit, :update, :destroy, :diagram, :validate]
  before_action :set_breadcrumb, only: [:edit, :diagram]

  layout 'diagram', only: [:diagram]

  def new
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm, panel: 'questions_sequences')
    add_breadcrumb t('breadcrumbs.questions_sequences')
    add_breadcrumb t('breadcrumbs.new')

    @questions_sequence = QuestionsSequence.new
    authorize @questions_sequence
    @questions_sequence.type = params[:type]
  end

  def edit
    add_breadcrumb @questions_sequence.label, diagram_questions_sequence_url(@questions_sequence)
    add_breadcrumb t('breadcrumbs.edit')
  end

  def create
    @questions_sequence = @algorithm.questions_sequences.new(questions_sequence_params)
    authorize policy_scope(QuestionsSequence)
    if @questions_sequence.save
      @questions_sequence.components.create!(node: @questions_sequence)
      if params[:from] == 'rails'
        render json: { url: diagram_questions_sequence_url(@questions_sequence) }
      else
        type = params[:instanceable_type].camelize.singularize
        if %w(Diagnostic QuestionsSequence).include? type
          instanceable = Object.const_get(params[:instanceable_type].camelize.singularize).find(params[:instanceable_id])
          instanceable.components.create!(node: @questions_sequence, final_diagnostic_id: params[:final_diagnostic_id])
        end
        render json: @questions_sequence.get_instance_json(instanceable)
      end
    else
      render json: @questions_sequence.errors.full_messages, status: 422
    end
  end

  def update
    if @questions_sequence.update(questions_sequence_params)
      if params[:from] == 'rails'
        render json: { url: algorithm_url(@algorithm, panel: 'questions_sequences') }
      else
        render json: @questions_sequence.as_json(include: [:complaint_categories], methods: [:node_type, :type, :category_name])
      end
    else
      render json: @questions_sequence.errors.full_messages, status: 422
    end
  end

  def destroy
    # If user remove 'disabled' css in button, we verify in controller
    if @questions_sequence.dependencies?
      redirect_to algorithm_url(@algorithm, panel: 'questions_sequences'), alert: t('dependencies')
    else
      if @questions_sequence.destroy
        redirect_to algorithm_url(@algorithm, panel: 'questions_sequences'), notice: t('flash_message.success_updated')
      else
        redirect_to algorithm_url(@algorithm, panel: 'questions_sequences'), alert: t('error')
      end
    end
  end

  # React Diagram
  def diagram
    authorize policy_scope(QuestionsSequence)
  end

  # GET
  # @return give sub categories of questions sequence
  def lists
    authorize policy_scope(QuestionsSequence)
    render json: {
      categories: QuestionsSequence.categories,
      complaint_categories: @algorithm.questions.where(type: 'Questions::ComplaintCategory')
    }
  end

  # GET algorithm/:algorithm_id/questions_sequences/reference_prefix/:type
  # @params QuestionsSequence child
  # @return json with the reference prefix of the child
  def reference_prefix
    authorize policy_scope(QuestionsSequence)
    render json: QuestionsSequence.reference_prefix_class(params[:type])
  end

  # @params [QuestionsSequence]
  # Manually validate a questions sequence and return flash messages to display in the view
  def validate
    @questions_sequence.manual_validate
    if @questions_sequence.errors.messages.any?
      render json: @questions_sequence.errors.messages[:basic], status: 422
    else
      render json: [t('flash_message.diagnostic.valid')], status: 200
    end
  end

  private

  def set_breadcrumb
    panel = (@questions_sequence.is_a?(QuestionsSequences::Scored)) ? 'questions_sequences_scored' : 'questions_sequences'
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @questions_sequence.algorithm.name, algorithm_url(@questions_sequence.algorithm, panel: panel)
    add_breadcrumb t('breadcrumbs.questions_sequences')
  end

  def set_questions_sequence
    @questions_sequence = Node.find(params[:id])
    authorize @questions_sequence
  end

  def questions_sequence_params
    params.require(:questions_sequence).permit(
      :id,
      :reference,
      :label_en,
      Language.label_params,
      :description_en,
      Language.description_params,
      :type,
      :algorithm_id,
      :min_score,
      :node_id,
      complaint_category_ids: []
    )
  end

end
