class FinalDiagnosticHealthCaresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :set_version, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :set_diagnostic, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :set_final_diagnostic, only: [:create, :show, :edit, :update, :destroy]
  before_action :set_final_diagnostic_health_care, only: [:destroy]

  def create
    authorize policy_scope(FinalDiagnosticHealthCare)
    final_diagnostic_health_care = FinalDiagnosticHealthCare.create(final_diagnostic_health_care_params)
    final_diagnostic_health_care.final_diagnostic_id = params[:final_diagnostic_id]

    if final_diagnostic_health_care.save
      redirect_to algorithm_version_diagnostic_final_diagnostic_url(@algorithm, @version, @diagnostic, @final_diagnostic), notice: t('flash_message.success_created')
    else
      redirect_to algorithm_version_diagnostic_final_diagnostic_url(@algorithm, @version, @diagnostic, @final_diagnostic), alert: t('flash_message.update_fail')
    end
  end

  def destroy
    if @final_diagnostic_health_care.destroy
      redirect_to algorithm_version_diagnostic_final_diagnostic_url(@algorithm, @version, @diagnostic, @final_diagnostic), notice: t('flash_message.success_deleted')
    else
      redirect_to algorithm_version_diagnostic_final_diagnostic_url(@algorithm, @version, @diagnostic, @final_diagnostic), alert: t('flash_message.update_fail')
    end
  end

  private

  def set_diagnostic
    @diagnostic = Diagnostic.find(params[:diagnostic_id])
  end

  def set_final_diagnostic
    @final_diagnostic = Node.find(params[:final_diagnostic_id])
  end

  def set_final_diagnostic_health_care
    @final_diagnostic_health_care = FinalDiagnosticHealthCare.find(params[:id])
    authorize @final_diagnostic_health_care
  end

  def final_diagnostic_health_care_params
    params.require(:final_diagnostic_health_care).permit(
      :id,
      :node_id,
      :final_diagnostic_id
    )
  end
end
