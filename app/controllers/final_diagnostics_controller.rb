class FinalDiagnosticsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:add_treatable, :show, :new, :create, :edit, :update, :destroy]
  before_action :set_algorithm_version, only: [:add_treatable, :show, :new, :create, :edit, :update, :destroy]
  before_action :set_diagnostic, only: [:add_treatable, :show, :new, :create, :edit, :update, :destroy]
  before_action :set_final_diagnostic, only: [:add_treatable, :show, :edit, :update, :destroy]

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

  private

  def set_algorithm
    @algorithm = Algorithm.find(params[:algorithm_id])
  end

  def set_algorithm_version
    @algorithm_version = AlgorithmVersion.find(params[:algorithm_version_id])
  end

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
      :description
    )
  end
end
