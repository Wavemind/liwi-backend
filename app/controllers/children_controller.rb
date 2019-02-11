class ChildrenController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:index, :show, :create, :destroy]
  before_action :set_algorithm_version, only: [:index, :show, :create, :destroy]
  before_action :set_relationable, only: [:index, :show, :create, :destroy]
  before_action :set_relation, only: [:show, :create, :destroy]
  before_action :set_child, only: [:destroy]

  def create
    @child = Child.new(child_params)
    @child.relation = @relation

    if @child.save
      redirect_to polymorphic_url([@algorithm, @algorithm_version, @relationable, @relation]), notice: t('flash_message.success_created')
    else
      redirect_to polymorphic_url([@algorithm, @algorithm_version, @relationable, @relation]), alert: t('error')
    end
  end

  def destroy
    if @child.destroy
      redirect_to polymorphic_url([@algorithm, @algorithm_version, @relationable, @relation]), notice: t('flash_message.success_updated')
    else
      redirect_to polymorphic_url([@algorithm, @algorithm_version, @relationable, @relation]), alert: t('error')
    end
  end

  private

  def set_child
    @child = Child.find(params[:id])
  end

  def set_relation
    @relation = Relation.find(params[:relation_id])
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

  def child_params
    params.require(:child).permit(
      :id,
      :weight,
      :node_id,
      :relation_id
    )
  end


end
