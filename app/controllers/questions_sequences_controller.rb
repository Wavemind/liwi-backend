class QuestionsSequencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:new_scored, :edit_scored, :new, :create, :edit, :update, :destroy, :questions_sequence, :create_from_diagram, :update_from_diagram]
  before_action :set_questions_sequence, only: [:edit, :edit_scored, :update, :destroy, :update_translations, :diagram, :validate, :update_from_diagram]
  before_action :set_breadcrumb, only: [:edit, :diagram]

  layout 'diagram', only: [:diagram]

  def new
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm, panel: 'questions_sequences')
    add_breadcrumb t('breadcrumbs.questions_sequences')
    add_breadcrumb t('breadcrumbs.new')

    @questions_sequence = QuestionsSequence.new
    @questions_sequence.type = nil
  end

  def edit
    add_breadcrumb @questions_sequence.label, diagram_questions_sequence_url(@questions_sequence)
    add_breadcrumb t('breadcrumbs.edit')
  end

  def create
    @questions_sequence = @algorithm.questions_sequences.new(questions_sequence_params)

    if @questions_sequence.save
      @questions_sequence.components.create!(node: @questions_sequence)
      redirect_to diagram_questions_sequence_url(@questions_sequence), notice: t('flash_message.success_updated')
    else
      set_breadcrumb
      add_breadcrumb t('breadcrumbs.new')

      if @questions_sequence.is_a?(QuestionsSequences::Scored)
        render :new_scored
      else
        render :new
      end
    end
  end

  def update
    if @questions_sequence.update(questions_sequence_params)
      redirect_to algorithm_url(@algorithm, panel: 'questions_sequences'), notice: t('flash_message.success_updated')
    else
      set_breadcrumb
      add_breadcrumb t('breadcrumbs.edit')
      render :edit
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

  # POST
  # @return  node
  # Create a questions sequence node from diagram and instance it
  def create_from_diagram
    questions_sequence = @algorithm.questions_sequences.new(questions_sequence_params)
    questions_sequence.becomes(Object.const_get(questions_sequence_params[:type])) if questions_sequence_params[:type].present?
    if questions_sequence.save
      questions_sequence.components.create!(node: questions_sequence)
      Object.const_get(params[:instanceable_type].camelize.singularize).find(params[:instanceable_id]).components.create!(node: questions_sequence, final_diagnostic_id: params[:final_diagnostic_id])
      render json: {status: 'success', messages: [t('flash_message.success_created')], node: questions_sequence.as_json(include: :answers, methods: [:node_type, :category_name, :type])}
    else
      render json: {status: 'danger', errors: questions_sequence.errors.messages, ok: false}
    end
  end

  # React Diagram
  def diagram
  end

  # @params QuestionSequence scored
  # Update a QuestionSequence scored
  def edit_scored
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm, panel: 'questions_sequences_scored')
    add_breadcrumb @questions_sequence.label
  end

  # Create a new QuestionSequence scored
  def new_scored
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm, panel: 'questions_sequences_scored')

    @questions_sequence = QuestionsSequence.new
    @questions_sequence.type = nil
  end

  # GET algorithm/:algorithm_id/questions_sequences/reference_prefix/:type
  # @params QuestionsSequence child
  # @return json with the reference prefix of the child
  def reference_prefix
    render json: QuestionsSequence.reference_prefix_class(params[:type])
  end

  # PUT
  # @return questions_sequence node
  # Update a questions sequence node from diagram
  def update_from_diagram
    if @questions_sequence.update(questions_sequence_params)
      render json: {status: 'success', messages: [t('flash_message.success_updated')], node: @questions_sequence.as_json(include: :answers, methods: [:category_name, :node_type, :type])}
    else
      render json: {status: 'danger', errors: @questions_sequence.errors.messages, ok: false}
    end
  end

  # @params QuestionsSequence with the translations
  # Update the object with its translation without rendering a new page
  def update_translations
    if @questions_sequence.update(questions_sequence_params)
      @json = { status: 'success', message: t('flash_message.success_updated') }
      render 'diagnostics/update_translations', formats: :js, status: :ok
    else
      @json = { status: 'alert', message: t('flash_message.update_fail') }
      render 'diagnostics/update_translations', formats: :js, status: :unprocessable_entity
    end
  end

  # @params [QuestionsSequence]
  # Manually validate a questions sequence and return flash messages to display in the view
  def validate
    @questions_sequence.manual_validate
    if @questions_sequence.errors.messages.any?
      render json: {status: 'danger', messages: @questions_sequence.errors.messages[:basic]}
    else
      render json: {status: 'success', messages: [t('flash_message.diagnostic.valid')]}
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
      )
  end

end
