class InstancesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_instanceable, only: [:show, :create, :destroy, :create_link, :remove_link]
  before_action :set_instance, only: [:show, :destroy, :update, :create_link, :remove_link]

  def index
    authorize policy_scope(Instance)
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

    if params[:diagnosis_id].present?
      @algorithm = @instanceable.version.algorithm

      add_breadcrumb @algorithm.name, algorithm_url(@algorithm)
      add_breadcrumb @instanceable.version.name, algorithm_version_url(@algorithm, @instanceable.version)
      add_breadcrumb @instanceable.label, algorithm_version_diagnosis_url(@algorithm, @instanceable.version, @instanceable)
      add_breadcrumb @instance.node.label
    else
      @algorithm = @instanceable.algorithm

      add_breadcrumb @algorithm.name, algorithm_url(@algorithm)
      add_breadcrumb @instanceable.label, questions_sequence_url(@instanceable)
      add_breadcrumb @instance.node.label
    end
  end

  def create
    authorize policy_scope(Instance)
    instance = @instanceable.components.new(instance_params)

    if instance.node.is_a?(QuestionsSequence) && QuestionsSequence.is_loop(@instanceable, instance.node)
      instance.errors.add(:base, t('questions_sequences.validation.loop'))
      render json: instance.errors.full_messages, status: 422
    elsif instance.save
      render json: instance.generate_json
    else
      render json: instance.errors.full_messages, status: 422
    end
  end

  def update
    if @instance.update(instance_params)
      render json: @instance.generate_json
    else
      render json: @instance.errors.full_messages, status: 422
    end
  end

  def destroy
    if @instance.destroy
      render json: @instance
    else
      render json: @instance.errors.full_messages, status: 422
    end
  end

  # POST /instanceable_type/:instanceable_id/instances/:id/create_link
  # @params [Instance] Instance of the child
  # @params [Answer] Answer from parent of the link
  # @params [Integer] Score to add to the condition
  # Create link in both way from diagram
  def create_link
    condition = @instance.conditions.new(answer_id: instance_params[:answer_id], score: instance_params[:score])
    if condition.save
      render json: condition
    else
      render json: condition.errors.full_messages, status: 422
    end
  end

  # DELETE /instanceable_type/:instanceable_id/instances/:id/create_link
  # Remove a link from diagram and remove from both child and parent concerned
  # @params [Instance] Parent of the link
  # @params [Condition] condition to be removed
  def remove_link
    condition = Condition.find(instance_params[:condition_id])
    Instance.remove_condition(condition, @instance)
    render json: condition
  end

  # PUT /questions_sequences/:questions_sequence_id/instances/update_score
  # @params [Condition] Condition to update
  # Update the score of a condition in a QSS
  def update_score
    authorize policy_scope(Instance)
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
    @child_instance = @instanceable.components.find_by(node_id: @child_node.id, final_diagnosis_id: instance_params[:final_diagnosis_id])
  end

  def set_instance
    @instance = Instance.find(params[:id])
    authorize @instance
  end

  def set_instanceable
    if params[:diagnosis_id].present?
      @instanceable = Diagnosis.find(params[:diagnosis_id])
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
      :final_diagnosis_id,
      Language.language_params('duration'),
      Language.language_params('description'),
      :is_pre_referral
    )
  end
end
