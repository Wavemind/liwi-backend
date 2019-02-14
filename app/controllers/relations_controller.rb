class RelationsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_relationable, only: [:show, :create, :destroy]
  before_action :set_relation, only: [:show, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { render json: RelationDatatable.new(params, view_context: view_context) }
    end
  end

  def show
    @children = @relation.children.includes(:node)
    @child = Child.new

    @conditions = @relation.conditions
    @condition = Condition.new

    if params[:diagnostic_id].present?
      @algorithm = @relationable.algorithm_version.algorithm

      add_breadcrumb "#{@algorithm.name}", algorithm_url(@algorithm)
      add_breadcrumb "#{@relationable.algorithm_version.version}", algorithm_algorithm_version_url(@algorithm, @relationable.algorithm_version)
      add_breadcrumb "#{@relationable.label}", algorithm_algorithm_version_diagnostic_url(@algorithm, @relationable.algorithm_version, @relationable)
      add_breadcrumb "#{@relation.node.label}"
    else
      @algorithm = @relationable.algorithm

      add_breadcrumb "#{@algorithm.name}", algorithm_url(@algorithm)
      add_breadcrumb "#{@relationable.label}", predefined_syndrome_url(@relationable)
      add_breadcrumb "#{@relation.node.label}"
    end
  end

  def create
    @relation = Relation.new(relation_params)
    @relation.relationable = @relationable

    if @relation.save
      redirect_to polymorphic_url([@relationable, @relation]), notice: t('flash_message.success_created')
    else
      redirect_back fallback_location: root_path, alert: t('error')
    end
  end

  def destroy
    if @relation.destroy
      redirect_back fallback_location: root_path, notice: t('flash_message.success_updated')
    else
      redirect_back fallback_location: root_path, alert: t('error')
    end
  end

  private

  def set_relation
    @relation = Relation.find(params[:id])
  end

  def set_relationable
    if params[:diagnostic_id].present?
      @relationable = Diagnostic.find(params[:diagnostic_id])
    elsif params[:predefined_syndrome_id].present?
      @relationable = PredefinedSyndrome.find(params[:predefined_syndrome_id])
    else
      raise
    end
  end

  def relation_params
    params.require(:relation).permit(
      :id,
      :node_id,
      :relationable_id,
      :relationable_type
    )
  end
end
