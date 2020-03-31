class InstancesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_instanceable, only: [:show, :create, :destroy, :by_reference, :create_link, :remove_link]
  before_action :set_instance, only: [:show, :destroy, :update, :create_link, :remove_link]

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
      add_breadcrumb @instanceable.label, questions_sequence_url(@instanceable)
      add_breadcrumb @instance.node.label
    end
  end

  def create
    instance = @instanceable.components.new(instance_params)

    if instance.node.is_a?(HealthCare)
      FinalDiagnosticHealthCare.create!(final_diagnostic: FinalDiagnostic.find(instance_params[:final_diagnostic_id]), health_care: instance.node)
    end

    if instance.save
      render json: instance.generate_json
    else
      render json: instance.errors.full_messages, status: 422
    end
  end

  def destroy
    if instance_params[:final_diagnostic_id].present?
      FinalDiagnosticHealthCare.find_by(final_diagnostic_id: instance_params[:final_diagnostic_id], node_id: @instance.node_id).destroy if @instance.node.is_a?(HealthCare)
    end

    if @instance.destroy
      render json: @instance
    else
      render json: @instance.errors.full_messages, status: 422
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

  # @params [Diagnostic] Current diagnostic, [Answer] Answer from parent of the link, [Node] child of the link
  # Create link in both way from diagram
  def create_link
    condition = @instance.conditions.new(first_conditionable_type: 'Answer', first_conditionable_id: instance_params[:answer_id], top_level: true, score: instance_params[:score])
    if condition.save
      render json: condition
    else
      render json: condition.errors.full_messages, status: 422
    end
  end

  # Remove a link from diagram and remove from both child and parent concerned
  # @params [Instance] Parent of the link
  # @params [Condition] condition of the answer
  def remove_link
    condition = Condition.find(instance_params[:condition_id])
    Instance.remove_condition(condition, @instance)
    render json: condition
  end

  # POST /diagnostics/:diagnostic_id/instances/update_from_diagram
  # @return JSON of instance
  # Update an instances and return json format
  def update
    if @instance.update(instance_params)
      render json: @instance
    else
      render json: @instance.errors.full_messages, status: 422
    end
  end

  # @params [Diagnostic] Current diagnostic, [Answer] Answer from parent of the link, [Node] child of the link
  # Update the score of a condition in a PSS
  def update_score
    condition = Condition.find(instance_params[:condition_id])

    if condition.update(score: instance_params[:score])
      render json: condition
    else
      render json: condition.errors.full_messages, status: 422
    end
  end

  private

  def set_child
    @child_node = Node.find(instance_params[:node_id])
    @child_instance = @instanceable.components.find_by(node_id: @child_node.id, final_diagnostic_id: instance_params[:final_diagnostic_id])
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
      :position_x,
      :position_y,
      :instanceable_id,
      :instanceable_type,
      :answer_id,
      :condition_id,
      :score,
      :final_diagnostic_id,
      :duration,
      :description
    )
  end
end
