class DiagnosticsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_diagnostic, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { render json: DiagnosticDatatable.new(params, view_context: view_context) }
    end
  end

  def show
    @relation = Relation.new
    @relationable = @diagnostic

    @algorithm = @diagnostic.algorithm_versions.first.algorithm
  end

  def new
    @diagnostic = Diagnostic.new
  end

  def create
    @diagnostic = Diagnostic.new(diagnostic_params)
    @diagnostic.algorithm_versions << AlgorithmVersion.first

    if @diagnostic.save
      redirect_to @diagnostic, notice: t('flash_message.success_created')
    else
      render :new
    end
  end

  def update
    if @diagnostic.update(diagnostic_params)
      redirect_to @diagnostic, notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  def destroy
    if @diagnostic.destroy
      redirect_to @diagnostic, notice: t('flash_message.success_deleted')
    else
      render :new
    end
  end

  private

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
