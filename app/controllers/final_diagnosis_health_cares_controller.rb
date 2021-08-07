class FinalDiagnosisHealthCaresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :set_version, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :set_diagnosis, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :set_final_diagnosis, only: [:create, :show, :edit, :update, :destroy]
  before_action :set_final_diagnosis_health_care, only: [:destroy]

  def create
    authorize policy_scope(FinalDiagnosisHealthCare)
    final_diagnosis_health_care = FinalDiagnosisHealthCare.create(final_diagnosis_health_care_params)
    final_diagnosis_health_care.final_diagnosis_id = params[:final_diagnosis_id]

    if final_diagnosis_health_care.save
      redirect_to algorithm_version_diagnosis_final_diagnosis_url(@algorithm, @version, @diagnosis, @final_diagnosis), notice: t('flash_message.success_created')
    else
      redirect_to algorithm_version_diagnosis_final_diagnosis_url(@algorithm, @version, @diagnosis, @final_diagnosis), alert: t('flash_message.update_fail')
    end
  end

  def destroy
    if @final_diagnosis_health_care.destroy
      redirect_to algorithm_version_diagnosis_final_diagnosis_url(@algorithm, @version, @diagnosis, @final_diagnosis), notice: t('flash_message.success_deleted')
    else
      redirect_to algorithm_version_diagnosis_final_diagnosis_url(@algorithm, @version, @diagnosis, @final_diagnosis), alert: t('flash_message.update_fail')
    end
  end

  private

  def set_diagnosis
    @diagnosis = Diagnosis.find(params[:diagnosis_id])
  end

  def set_final_diagnosis
    @final_diagnosis = Node.find(params[:final_diagnosis_id])
  end

  def set_final_diagnosis_health_care
    @final_diagnosis_health_care = FinalDiagnosisHealthCare.find(params[:id])
    authorize @final_diagnosis_health_care
  end

  def final_diagnosis_health_care_params
    params.require(:final_diagnosis_health_care).permit(
      :id,
      :node_id,
      :final_diagnosis_id
    )
  end
end
