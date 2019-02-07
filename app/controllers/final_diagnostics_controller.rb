class DiagnosticsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:show, :new, :create, :edit]
  before_action :set_algorithm_version, only: [:show, :new, :create, :edit]
  before_action :set_diagnostic, only: [:show, :new, :create, :edit]
  before_action :set_final_diagnostic, only: [:show, :edit]

  def index
    respond_to do |format|
      format.html
      format.json { render json: FinalDiagnosticDatatable.new(params, view_context: view_context) }
    end
  end

  def show

  end

  def new
    @final_diagnostic = FinalDiagnostic.new
  end

  def create
    @final_diagnostic = @diagnostic.final_diagnostics.new(diagnostic_params)

    if @final_diagnostic.save
      redirect_to algorithm_algorithm_version_diagnostic_url(@algorithm, @algorithm_version, @diagnostic), notice: t('flash_message.success_created')
    else
      render :new
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

  def diagnostic_params
    params.require(:final_diagnostic).permit(
      :id,
      :label,
      :reference,
      :description
    )
  end
end
