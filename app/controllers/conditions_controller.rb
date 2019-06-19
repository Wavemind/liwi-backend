class ConditionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_instanceable, only: [:index, :show, :create, :destroy, :add_diagnostic_condition, :destroy_diagnostic_condition]
  before_action :set_instance, only: [:show, :create, :destroy]
  before_action :set_condition, only: [:destroy, :destroy_diagnostic_condition]

  def create
    @condition = @instance.conditions.new(condition_params)
    @condition.first_conditionable = @condition.create_conditionable(condition_params[:first_conditionable_id]) unless condition_params[:first_conditionable_id].empty?
    @condition.second_conditionable = @condition.create_conditionable(condition_params[:second_conditionable_id]) unless condition_params[:second_conditionable_id].empty?

    if @condition.save
      respond_to do |format|
        format.html {}
        format.json { render json: t('flash_message.success_created') }
      end
    else
      respond_to do |format|
        format.html {}
        format.json { render json: t('error') }
      end
    end
  end

  def destroy
    if @condition.destroy
      respond_to do |format|
        format.html {}
        format.json { render json: t('flash_message.success_created') }
      end
    else
      respond_to do |format|
        format.html {}
        format.json { render json: t('error') }
      end
    end
  end

  # POST /diagnostics/:diagnostic_id/conditions/differential
  # @return
  # Add diagnostic condition
  def add_diagnostic_condition
    @condition = @instanceable.conditions.new(condition_params)
    @condition.first_conditionable = @condition.create_conditionable(condition_params[:first_conditionable_id]) unless condition_params[:first_conditionable_id].empty?
    @condition.second_conditionable = @condition.create_conditionable(condition_params[:second_conditionable_id]) unless condition_params[:second_conditionable_id].empty?

    if @condition.save
      redirect_to algorithm_version_diagnostic_url(@instanceable.version.algorithm, @instanceable.version, @instanceable, panel: 'differential_conditions'), notice: t('flash_message.success_created')
    else
      redirect_to algorithm_version_diagnostic_url(@instanceable.version.algorithm, @instanceable.version, @instanceable, panel: 'differential_conditions'), alert: t('error')
    end
  end

  # DELETE /diagnostics/:diagnostic_id/conditions/:id/differential
  # @return
  # Destroy diagnostic condition
  def destroy_diagnostic_condition
    if @condition.destroy
      redirect_to algorithm_version_diagnostic_url(@instanceable.version.algorithm, @instanceable.version, @instanceable, panel: 'differential_conditions'), notice: t('flash_message.success_updated')
    else
      redirect_to algorithm_version_diagnostic_url(@instanceable.version.algorithm, @instanceable.version, @instanceable, panel: 'differential_conditions'), alert: t('error')
    end
  end

  private

  def set_condition
    @condition = Condition.find(params[:id])
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
