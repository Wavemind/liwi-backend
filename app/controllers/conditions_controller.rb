class ConditionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_instanceable, only: [:destroy]
  before_action :set_instance, only: [:destroy]
  before_action :set_condition, only: [:destroy]


  private

  def set_condition
    @condition = Condition.find(params[:id])
    authorize @condition
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
      :answer_id,
    )
  end

end
