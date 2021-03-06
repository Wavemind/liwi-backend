class ConditionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_instanceable, only: [:destroy]
  before_action :set_instance, only: [:destroy]
  before_action :set_condition, only: [:destroy, :update_cut_offs]


  # PUT conditions/:id/update_cut_offs
  # @params condition [Condition] condition to update
  # Update cut offs for the given link and return the object in json format
  def update_cut_offs
    if @condition.update(condition_params)
      render json: @condition.as_json
    else
      render json: @condition.errors.full_messages, status: 422
    end
  end

  private

  def set_condition
    @condition = Condition.find(params[:id])
    authorize @condition
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

  def condition_params
    params.require(:condition).permit(
      :id,
      :cut_off_start,
      :cut_off_end,
      :cut_off_value_type,
      :answer_id,
    )
  end

end
