class ConditionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_relationable, only: [:index, :show, :create, :destroy, :add_diagnostic_condition, :destroy_diagnostic_condition]
  before_action :set_relation, only: [:show, :create, :destroy]
  before_action :set_condition, only: [:destroy, :destroy_diagnostic_condition]

  def create
    @condition = @relation.conditions.new(condition_params)
    @condition.first_conditionable = @condition.create_conditionable(condition_params[:first_conditionable_id]) unless condition_params[:first_conditionable_id].empty?
    @condition.second_conditionable = @condition.create_conditionable(condition_params[:second_conditionable_id]) unless condition_params[:second_conditionable_id].empty?

    if @condition.save
      redirect_to polymorphic_url([@relationable, @relation]), notice: t('flash_message.success_created')
    else
      redirect_to polymorphic_url([@relationable, @relation]), alert: t('error')
    end
  end

  def destroy
    if @condition.destroy
      redirect_to polymorphic_url([@relationable, @relation]), notice: t('flash_message.success_updated')
    else
      redirect_to polymorphic_url([@relationable, @relation]), alert: t('error')
    end
  end

  # POST /diagnostics/:diagnostic_id/conditions/differential
  # @return
  # Add diagnostic condition
  def add_diagnostic_condition
    @condition = @relationable.conditions.new(condition_params)
    @condition.first_conditionable = @condition.create_conditionable(condition_params[:first_conditionable_id]) unless condition_params[:first_conditionable_id].empty?
    @condition.second_conditionable = @condition.create_conditionable(condition_params[:second_conditionable_id]) unless condition_params[:second_conditionable_id].empty?

    if @condition.save
      redirect_to algorithm_algorithm_version_diagnostic_url(@relationable.algorithm_version.algorithm, @relationable.algorithm_version, @relationable), notice: t('flash_message.success_created')
    else
      redirect_to algorithm_algorithm_version_diagnostic_url(@relationable.algorithm_version.algorithm, @relationable.algorithm_version, @relationable), alert: t('error')
    end
  end

  # DELETE /diagnostics/:diagnostic_id/conditions/:id/differential
  # @return
  # Destroy diagnostic condition
  def destroy_diagnostic_condition
    if @condition.destroy
      redirect_to algorithm_algorithm_version_diagnostic_url(@relationable.algorithm_version.algorithm, @relationable.algorithm_version, @relationable), notice: t('flash_message.success_updated')
    else
      redirect_to algorithm_algorithm_version_diagnostic_url(@relationable.algorithm_version.algorithm, @relationable.algorithm_version, @relationable), alert: t('error')
    end
  end

  private

  def set_condition
    @condition = Condition.find(params[:id])
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
