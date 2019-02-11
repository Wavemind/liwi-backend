class ConditionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:index, :show, :create, :destroy]
  before_action :set_algorithm_version, only: [:index, :show, :create, :destroy]
  before_action :set_diagnostic, only: [:index, :show, :create, :destroy]
  before_action :set_relation, only: [:show, :create, :destroy]
  before_action :set_condition, only: [:destroy]

  def create
    @condition = @relation.conditions.new(condition_params)
    @condition.first_conditionable_id = condition_params[:first_conditionable_id].split(',')[0]
    @condition.first_conditionable_type = condition_params[:first_conditionable_id].split(',')[1]
    @condition.second_conditionable_id = condition_params[:second_conditionable_id].split(',')[0]
    @condition.second_conditionable_type = condition_params[:second_conditionable_id].split(',')[1]

    if @condition.save
      redirect_to algorithm_algorithm_version_diagnostic_relation_url(@algorithm, @algorithm_version, @diagnostic, @relation), notice: t('flash_message.success_created')
    else
      redirect_to algorithm_algorithm_version_diagnostic_relation_url(@algorithm, @algorithm_version, @diagnostic, @relation), alert: t('error')
    end
  end

  def destroy
    if @condition.destroy
      redirect_to algorithm_algorithm_version_diagnostic_relation_url(@algorithm, @algorithm_version, @diagnostic, @relation), notice: t('flash_message.success_updated')
    else
      redirect_to algorithm_algorithm_version_diagnostic_relation_url(@algorithm, @algorithm_version, @diagnostic, @relation), alert: t('error')
    end
  end

  private

  def set_condition
    @condition = Condition.find(params[:id])
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

  def set_diagnostic
    @diagnostic = Diagnostic.find(params[:diagnostic_id])
  end

  def condition_params
    params.require(:condition).permit(
      :id,
      :operator,
      :first_conditionable_id,
      :second_conditionable_id,
      :top_level,
    )
  end


end
