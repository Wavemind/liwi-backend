class FinalDiagnosticsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:show, :new, :create, :edit, :update, :add_excluded_diagnostic, :remove_excluded_diagnostic]
  before_action :set_algorithm_version, only: [:show, :new, :create, :edit, :update, :add_excluded_diagnostic, :remove_excluded_diagnostic]
  before_action :set_diagnostic, only: [:show, :new, :create, :edit, :update, :destroy, :add_excluded_diagnostic, :remove_excluded_diagnostic]
  before_action :set_final_diagnostic, only: [:show, :edit, :update, :destroy, :add_excluded_diagnostic, :remove_excluded_diagnostic]

  def index
    respond_to do |format|
      format.html
      format.json { render json: FinalDiagnosticDatatable.new(params, view_context: view_context) }
    end
  end

  def new
    @final_diagnostic = FinalDiagnostic.new
  end

  def show
    add_breadcrumb "#{@algorithm.name}", algorithm_url(@algorithm)
    add_breadcrumb "#{@algorithm_version.name}", algorithm_algorithm_version_url(@algorithm, @algorithm_version)
    add_breadcrumb "#{@diagnostic.label}", algorithm_algorithm_version_diagnostic_url(@algorithm, @algorithm_version, @diagnostic)
    add_breadcrumb "#{@final_diagnostic.label}"

    @final_diagnostic_health_care = FinalDiagnosticHealthCare.new
    @treatments = @final_diagnostic.final_diagnostic_health_cares.treatments
    @managements = @final_diagnostic.final_diagnostic_health_cares.managements
  end

  def create
    @final_diagnostic = @diagnostic.final_diagnostics.new(final_diagnostic_params)

    if @final_diagnostic.save
      redirect_to algorithm_algorithm_version_diagnostic_url(@algorithm, @algorithm_version, @diagnostic), notice: t('flash_message.success_created')
    else
      render :new
    end
  end

  def update
    if @final_diagnostic.update(final_diagnostic_params)
      redirect_to algorithm_algorithm_version_diagnostic_url(@algorithm, @algorithm_version, @diagnostic), notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  def destroy
    if @final_diagnostic.destroy
      redirect_to algorithm_algorithm_version_diagnostic_url(@algorithm, @algorithm_version, @diagnostic), notice: t('flash_message.success_deleted')
    else
      redirect_to algorithm_algorithm_version_diagnostic_url(@algorithm, @algorithm_version, @diagnostic), alert: t('flash_message.update_fail')
    end
  end

  # POST /algorithms/:algorithm_id/algorithm_versions/:algorithm_version_id/diagnostics/:diagnostic_id/final_diagnostics/:id/add_excluded_diagnostic
  # @return
  # Add excluded diagnostic to final diagnostic
  def add_excluded_diagnostic
    if @final_diagnostic.update(final_diagnostic_params)
      redirect_to algorithm_algorithm_version_diagnostic_url(@algorithm, @algorithm_version, @diagnostic), notice: t('flash_message.success_updated')
    else
      redirect_to algorithm_algorithm_version_diagnostic_url(@algorithm, @algorithm_version, @diagnostic), alert: t('flash_message.update_fail')
    end
  end

  # DELETE /algorithms/:algorithm_id/algorithm_versions/:algorithm_version_id/diagnostics/:diagnostic_id/final_diagnostics/:id/remove_excluded_diagnostic
  # @return
  # Remove excluded diagnostic to final diagnostic
  def remove_excluded_diagnostic
    @final_diagnostic.excluded_diagnostic_id = nil
    if @final_diagnostic.save
      redirect_to algorithm_algorithm_version_diagnostic_url(@algorithm, @algorithm_version, @diagnostic), notice: t('flash_message.success_updated')
    else
      redirect_to algorithm_algorithm_version_diagnostic_url(@algorithm, @algorithm_version, @diagnostic), alert: t('flash_message.update_fail')
    end
  end

  private

  def set_diagnostic
    @diagnostic = Diagnostic.find(params[:diagnostic_id])
  end

  def set_final_diagnostic
    @final_diagnostic = Node.find(params[:id])
  end

  def final_diagnostic_params
    params.require(:final_diagnostic).permit(
      :id,
      :label,
      :reference,
      :final_diagnostic_id,
      :description
    )
  end
end
