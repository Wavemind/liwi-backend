class DiagnosticsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:show, :new, :create, :edit, :update]
  before_action :set_algorithm_version, only: [:show, :new, :create, :edit, :update]
  before_action :set_diagnostic, only: [:show, :edit, :update]

  def index
    respond_to do |format|
      format.html
      format.json { render json: DiagnosticDatatable.new(params, view_context: view_context) }
    end
  end

  def show
    @relation = Relation.new
    @relationable = @diagnostic
  end

  def new
    @diagnostic = Diagnostic.new
  end

  def create
    @diagnostic = Diagnostic.new(diagnostic_params)
    @diagnostic.algorithm_versions << @algorithm_version

    if @diagnostic.save
      redirect_to algorithm_algorithm_version_url(@algorithm, @algorithm_version), notice: t('flash_message.success_created')
    else
      render :new
    end
  end

  def update
    if @diagnostic.update(diagnostic_params)
      redirect_to algorithm_algorithm_version_url(@algorithm, @algorithm_version), notice: t('flash_message.success_updated')
    else
      render :edit
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
    @diagnostic = Diagnostic.find(params[:id])
  end

  def diagnostic_params
    params.require(:diagnostic).permit(
      :id,
      :label,
      :reference
    )
  end
end
