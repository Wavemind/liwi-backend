class RelationsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_algorithm, only: [:index, :show, :create, :destroy]
  before_action :set_algorithm_version, only: [:index, :show, :create, :destroy]
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
  end

  def create
    @relation = Relation.new(relation_params)
    @relation.relationable = @relationable

    if @relation.save
      redirect_to polymorphic_url([@algorithm, @algorithm_version, @relationable]), notice: t('flash_message.success_created')
    else
      redirect_to polymorphic_url([@algorithm, @algorithm_version, @relationable]), danger: t('error')
    end
  end

  def destroy
    if @relation.destroy
      redirect_to polymorphic_url([@algorithm, @algorithm_version, @relationable]), notice: t('flash_message.success_updated')
    else
      redirect_to polymorphic_url([@algorithm, @algorithm_version, @relationable]), danger: t('error')
    end
  end

  private

  def set_relation
    @relation = Relation.find(params[:id])
  end

  def set_algorithm
    @algorithm = Algorithm.find(params[:algorithm_id])
  end

  def set_algorithm_version
    @algorithm_version = AlgorithmVersion.find(params[:algorithm_version_id])
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
