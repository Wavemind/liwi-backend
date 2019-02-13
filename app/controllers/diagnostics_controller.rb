class DiagnosticsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:show, :new, :create, :edit, :update]
  before_action :set_algorithm_version, only: [:show, :new, :create, :edit, :update]
  before_action :set_diagnostic, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { render json: DiagnosticDatatable.new(params, view_context: view_context) }
    end
  end

  def show
    add_breadcrumb "#{@algorithm.name}", algorithm_url(@algorithm)
    add_breadcrumb "#{@algorithm_version.version}", algorithm_algorithm_version_url(@algorithm, @algorithm_version)
    add_breadcrumb "#{@diagnostic.label}"

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
      redirect_to algorithm_algorithm_version_diagnostic_url(@algorithm, @algorithm_version, @diagnostic), notice: t('flash_message.success_created')
    else
      render :new
    end
  end

  def update
    if @diagnostic.update(diagnostic_params)
      redirect_to algorithm_algorithm_version_diagnostic_url(@algorithm, @algorithm_version, @diagnostic), notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  def destroy
    if @diagnostic.destroy
      redirect_to algorithm_algorithm_version_diagnostic_url(@algorithm, @algorithm_version, @diagnostic), notice: t('flash_message.success_deleted')
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
