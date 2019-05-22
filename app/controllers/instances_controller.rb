class InstancesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_instanceable, only: [:show, :create, :destroy, :by_reference, :create_from_diagram, :remove_from_diagram, :create_link, :remove_link, :load_conditions, :create_from_final_diagnostic_diagram, :update_score]
  before_action :set_instance, only: [:show, :destroy]
  before_action :set_child, only: [:create_link, :remove_link, :update_score]
  before_action :set_parent, only: [:create_link, :remove_link, :update_score]

  def index
    respond_to do |format|
      format.html
      format.json { render json: InstanceDatatable.new(params, view_context: view_context) }
    end
  end

  def show
    @children = @instance.children.includes(:node)
    @child = Child.new

    @conditions = @instance.conditions
    @condition = Condition.new

    if params[:diagnostic_id].present?
      @algorithm = @instanceable.version.algorithm

      add_breadcrumb @algorithm.name, algorithm_url(@algorithm)
      add_breadcrumb @instanceable.version.name, algorithm_version_url(@algorithm, @instanceable.version)
      add_breadcrumb @instanceable.label, algorithm_version_diagnostic_url(@algorithm, @instanceable.version, @instanceable)
      add_breadcrumb @instance.node.label
    else
      @algorithm = @instanceable.algorithm

      add_breadcrumb @algorithm.name, algorithm_url(@algorithm)
      add_breadcrumb @instanceable.label, predefined_syndrome_url(@instanceable)
      add_breadcrumb @instance.node.label
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

  # POST /diagnostics/:diagnostic_id/instances/diagram_create
  # @return JSON of instance
  # Create an instances of node for final diagnostic diagram and return json format
  def create_from_final_diagnostic_diagram
    instance = @instanceable.components.new(instance_params)

    if instance.node.is_a?(Treatment) || instance.node.is_a?(Management)
      FinalDiagnosticHealthCare.create!(final_diagnostic: FinalDiagnostic.find(instance_params[:final_diagnostic_id]), node: instance.node)
    end

    instance.save

    respond_to do |format|
      format.html {}
      format.json { render json: instance }
    end
  end

  # @params [Diagnostic] Current diagnostic, [Answer] Answer from parent of the link, [Node] child of the link
  # Create link in both way from diagram
  def create_link
    condition = Condition.new(referenceable: @child_instance, first_conditionable: @parent_answer, top_level: true, score: params[:score])
    if condition.save
      render json: { status: 'success', message: t('flash_message.success_created') }
    else
      render json: { status: 'danger', message: condition.errors.full_messages }
    end
  end

  # @params [Diagnostic] Current diagnostic [Node] child of the link
  # Create link in both way from diagram
  def load_conditions
    instance = @instanceable.components.find_by(node_id: params[:node_id])
    available_conditions = (@instanceable.components.questions.includes(node: [:answers]).map(&:node).map(&:answers) + @instanceable.components.predefined_syndromes.includes(node: [:answers]).map(&:node).map(&:answers) + instance.conditions).flatten
    render json: {
      instance: instance.as_json(
        include: {
          conditions: {
            include: [
              first_conditionable: {
                include: [node: { include: [:answers] }]
              },
              second_conditionable: {
                include: [
                  node: { include: [:answers] }
                ]
              }
            ],
            methods: [:display_condition]
          },
        }
      ),
      available_conditions: available_conditions.as_json(methods: [:display_condition]),
      operators: Condition.operators.map { |k, v| [t("conditions.operators.#{k}"), k] }.as_json
    }
  end

  # POST /diagnostics/:diagnostic_id/instances/:node_id/remove_from_diagram
  # @return JSON of instance
  # Delete an instances and json format
  def remove_from_diagram
    # Remove from HealthCare diagram (in case there are 2 instances of one node for one diagnostic, one df condition and one hc condition)
    if instance_params[:final_diagnostic_id].present?
      instance = @instanceable.components.health_care_conditions.find_by(node_id: instance_params[:node_id])
      FinalDiagnosticHealthCare.find_by(final_diagnostic_id: instance_params[:final_diagnostic_id], node_id: instance.node_id).destroy! if (instance.node.is_a?(Treatment) || instance.node.is_a?(Management))
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

  # @params [Diagnostic] Current diagnostic, [Answer] Answer from parent of the link, [Node] child of the link
  # Update the score of a condition of a PSS
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
    elsif params[:predefined_syndrome_id].present?
      @instanceable = PredefinedSyndrome.find(params[:predefined_syndrome_id])
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
      :final_diagnostic_id
    )
  end
end
