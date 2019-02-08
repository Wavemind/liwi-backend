class RelationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:index, :create, :destroy]
  before_action :set_algorithm_version, only: [:index, :create, :destroy]
  before_action :set_diagnostic, only: [:index, :create, :destroy]
  before_action :set_relation, only: [:destroy]

  def index
    respond_to do |format|
      format.html
      format.json { render json: RelationDatatable.new(params, view_context: view_context) }
    end
  end

  def create
    @relation = Relation.new(relation_params)
    @relation.relationable = @diagnostic

    if @relation.save
      redirect_to algorithm_algorithm_version_diagnostic_url(@algorithm, @algorithm_version, @diagnostic), notice: t('flash_message.success_created')
    else
      redirect_to algorithm_algorithm_version_diagnostic_url(@algorithm, @algorithm_version, @diagnostic), danger: t('error')
    end
  end
e
  def destroy
    if @relation.destroy
      redirect_to algorithm_algorithm_version_diagnostic_url(@algorithm, @algorithm_version, @diagnostic), notice: t('flash_message.success_updated')
    else
      redirect_to algorithm_algorithm_version_diagnostic_url(@algorithm, @algorithm_version, @diagnostic), danger: t('error')
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

  def set_diagnostic
    @diagnostic = Diagnostic.find(params[:diagnostic_id])
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
