class InstancesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_instanceable, only: [:show, :create, :destroy, :by_reference, :create_from_diagram, :remove_from_diagram, :create_link, :remove_link, :create_from_final_diagnostic_diagram, :update_score]
  before_action :set_instance, only: [:show, :destroy, :update_from_final_diagnostic_diagram]
  before_action :set_child, only: [:create_link, :remove_link, :update_score]
  before_action :set_parent, only: [:create_link, :remove_link, :update_score]

  def index
    respond_to do |format|
      format.html
      format.json { render json: InstanceDatatable.new(params, view_context: view_context) }
    end
  end

  def create
    @instance = Instance.new(instance_params)
    @instance.instanceable = @instanceable

    if @instance.save
      redirect_to polymorphic_url([@instanceable, @instance]), notice: t('flash_message.success_created')
    else
      redirect_back fallback_location: root_path, alert: t('error')
    end
  end

  def destroy
    if @instance.destroy
      redirect_back fallback_location: root_path, notice: t('flash_message.success_updated')
    else
      redirect_back fallback_location: root_path, alert: t('error')
    end
  end

  # @params [String] reference
  # Find an instance by its node reference
  def by_reference
    if params[:diagnostic_id].present?
      @node = @instanceable.version.algorithm.nodes.find_by(reference: params[:reference]);
    else
      @node = @instanceable.algorithm.nodes.find_by(reference: params[:reference]);
    end
    render json: polymorphic_url([@instanceable, @instanceable.components.find_by(node: @node)])
  end

  # POST /diagnostics/:diagnostic_id/instances/diagram_create
  # @return JSON of instance
  # Create an instances and return json format
  def create_from_diagram
    instance = @instanceable.components.new(instance_params)
    instance.save

    respond_to do |format|
      format.html {}
      format.json { render json: instance }
    end
  end

  # POST /diagnostics/:diagnostic_id/instances/create_from_final_diagnostic_diagram
  # @return JSON of instance
  # Create an instances of node for final diagnostic diagram and return json format
  def create_from_final_diagnostic_diagram
    instance = @instanceable.components.new(instance_params)

    if instance.node.is_a?(HealthCare)
      FinalDiagnosticHealthCare.create!(final_diagnostic: FinalDiagnostic.find(instance_params[:final_diagnostic_id]), health_care: instance.node)
    end

    instance.save
    if instance.node.is_a?(HealthCares::Drug)
      respond_to do |format|
        format.html {}
        format.json { render json: instance.as_json(include: [node: {include: [:formulations], methods: [:node_type, :type, :category_name]}, conditions: { include: [first_conditionable: { methods: [:get_node] }]}])}
      end
    else
      respond_to do |format|
        format.html {}
        format.json { render json: instance.as_json(include: [node: {methods: [:node_type, :type, :category_name]}, conditions: { include: [first_conditionable: { methods: [:get_node] }]}])}
      end
    end
  end

  # @params [Diagnostic] Current diagnostic, [Answer] Answer from parent of the link, [Node] child of the link
  # Create link in both way from diagram
  def create_link
    condition = Condition.new(referenceable: @child_instance, first_conditionable: @parent_answer, top_level: true, score: params[:score])
    if condition.save
      render json: { status: 'success', statusText: t('flash_message.success_created') }
    else
      render json: { status: 'danger', statusText: condition.errors.full_messages, ok: false }
    end
  end

  # POST /diagnostics/:diagnostic_id/instances/:node_id/remove_from_diagram
  # @return JSON of instance
  # Delete an instances and json format
  def remove_from_diagram
    # Remove from HealthCare diagram (in case there are 2 instances of one node for one diagnostic, one df condition and one hc condition)
    if instance_params[:final_diagnostic_id].present?
      instance = @instanceable.components.health_care_conditions.find_by(node_id: instance_params[:node_id])
      FinalDiagnosticHealthCare.find_by(final_diagnostic_id: instance_params[:final_diagnostic_id], node_id: instance.node_id).destroy! if instance.node.is_a?(HealthCare)
    else
      instance = @instanceable.components.not_health_care_conditions.find_by(node_id: instance_params[:node_id])
    end
    instance.destroy!

    respond_to do |format|
      format.html {}
      format.json { render json: @instance }
    end
  end

  # @params [Diagnostic] Current diagnostic, [Answer] Answer from parent of the link, [Node] child of the link
  # Remove a link from diagram and remove from both child and parent concerned
  def remove_link
    condition = Condition.find_by(referenceable: @child_instance, first_conditionable: @parent_answer)
    Instance.remove_condition(condition, @parent_instance)
    render json: { status: 'success', message: t('flash_message.success_deleted') }
  end

  # POST /diagnostics/:diagnostic_id/instances/update_from_final_diagnostic_diagram
  # @return JSON of instance
  # Update an instance of node for final diagnostic diagram and return json format
  def update_from_final_diagnostic_diagram
    if @instance.update(instance_params)
      respond_to do |format|
        format.html {}
        format.json { render json: @instance.as_json(include: [node: {include: [:formulations], methods: [:node_type, :type, :category_name]}, conditions: { include: [first_conditionable: { methods: [:get_node] }]}])}
      end
    else
      respond_to do |format|
        format.html {}
        format.json { render json: {ok: false, errors: @instance.errors.messages }}
      end
    end
  end

  # @params [Diagnostic] Current diagnostic, [Answer] Answer from parent of the link, [Node] child of the link
  # Update the score of a condition in a PSS
  def update_score
    condition = Condition.find_by(first_conditionable: @parent_answer, referenceable: @child_instance)

    if condition.update!(score: params[:score])
      render json: { status: 'success', message: t('flash_message.success_updated') }
    else
      render json: { status: 'danger', message: condition.errors.full_messages }
    end
  end

  private

  def set_child
    @child_node = Node.find(instance_params[:node_id])
    @child_instance = @instanceable.components.find_by(node_id: @child_node.id, final_diagnostic_id: instance_params[:final_diagnostic_id])
  end

  def set_parent
    @parent_answer = Answer.find(instance_params[:answer_id])
    @parent_instance = @instanceable.components.find_by(node_id: @parent_answer.node_id, final_diagnostic_id: instance_params[:final_diagnostic_id])
  end

  def set_instance
    @instance = Instance.find(params[:id])
  end

  def set_instanceable
    if params[:diagnostic_id].present?
      @instanceable = Diagnostic.find(params[:diagnostic_id])
    elsif params[:questions_sequence_id].present?
      @instanceable = QuestionsSequence.find(params[:questions_sequence_id])
    else
      raise
    end
  end

  def instance_params
    params.require(:instance).permit(
      :id,
      :node_id,
      :instanceable_id,
      :instanceable_type,
      :answer_id,
      :final_diagnostic_id,
      :duration,
      :description
    )
  end
end
