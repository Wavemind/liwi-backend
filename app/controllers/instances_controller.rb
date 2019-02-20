class InstancesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_instanceable, only: [:show, :create, :destroy]
  before_action :set_instance, only: [:show, :destroy]

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

  private

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
      :instanceable_type
    )
  end
end