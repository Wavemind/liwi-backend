class FinalDiagnosticsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:new, :create, :edit, :update, :destroy, :remove_exclusion, :add_exclusion]
  before_action :set_diagnostic, only: [:new, :create, :edit, :update, :destroy, :diagram]
  before_action :set_final_diagnostic, only: [:edit, :update, :destroy, :diagram]
  before_action :set_version, only: [:new, :create, :edit, :update, :destroy, :remove_exclusion, :add_exclusion]
  before_action :set_breadcrumb, only: [:new, :edit]
  layout 'diagram', only: [:diagram]

  def index
    respond_to do |format|
      format.html
      format.json { render json: FinalDiagnosticDatatable.new(params, view_context: view_context) }
    end
  end

  def new
    add_breadcrumb @diagnostic.label, algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic, panel: 'final_diagnostics')
    add_breadcrumb t('breadcrumbs.new')

    @final_diagnostic = FinalDiagnostic.new
  end

  def edit
    add_breadcrumb @diagnostic.label, algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic, panel: 'final_diagnostics')
    add_breadcrumb t('breadcrumbs.final_diagnostics')
    add_breadcrumb @final_diagnostic.label
    add_breadcrumb t('breadcrumbs.edit')
  end

  def create
    @final_diagnostic = @diagnostic.final_diagnostics.new(final_diagnostic_params)

    if @final_diagnostic.save
      @diagnostic.components.create!(node: @final_diagnostic)
      if params[:from] == 'rails'
        render json: { url: algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic, panel: 'final_diagnostics'), finalDiagnostic: @final_diagnostic }
      else
        render json: @final_diagnostic.get_instance_json
      end
    else
      render json: @final_diagnostic.errors.full_messages, status: 422
    end
  end

  def update
    if @final_diagnostic.update(final_diagnostic_params)
      if params[:from] == 'rails'
        render json: { url: algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic, panel: 'final_diagnostics'), finalDiagnostic: @final_diagnostic }
      else
        render json: @final_diagnostic.as_json(methods: [:node_type])
      end
    else
      render json: @final_diagnostic.errors.full_messages, status: 422
    end
  end

  def destroy
    # If user remove 'disabled' css in button, we verify in controller
    if @final_diagnostic.dependencies?
      redirect_to algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic, panel: 'final_diagnostics'), alert: t('dependencies')
    else
      if @final_diagnostic.destroy
        redirect_to algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic, panel: 'final_diagnostics'), notice: t('flash_message.success_updated')
      else
        redirect_to algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic, panel: 'final_diagnostics'), alert: t('error')
      end
    end
  end

  # POST /algorithms/:algorithm_id/versions/:version_id/final_diagnostics/:id/add_excluded_diagnostic
  # @return
  # Add excluded diagnostic to final diagnostic
  def add_exclusion
    @final_diagnosis_exclusion = NodeExclusion.new(final_diagnosis_exclusion_params)
    @final_diagnosis_exclusion.node_type = :final_diagnostic
    if @final_diagnosis_exclusion.save
      respond_to do |format|
        format.html { redirect_to algorithm_version_url(@algorithm.id, @version.id, panel: 'final_diagnoses_exclusions'), notice: t('flash_message.success_updated') }
        format.json { render json: @final_diagnosis_exclusion.excluding_node }
      end
    else
      respond_to do |format|
        format.html { redirect_to algorithm_version_url(@algorithm, @version, panel: 'final_diagnoses_exclusions'), alert: @final_diagnosis_exclusion.errors.full_messages }
        format.json { render json: @final_diagnosis_exclusion.errors.full_messages, status: 422 }
      end
    end
  end

  # Generate react diagram
  def diagram
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @final_diagnostic.diagnostic.version.algorithm.name, algorithm_url(@final_diagnostic.diagnostic.version.algorithm)
    add_breadcrumb "#{t('breadcrumbs.versions')} : #{@final_diagnostic.diagnostic.version.name}", algorithm_version_url(@final_diagnostic.diagnostic.version.algorithm, @final_diagnostic.diagnostic.version)
    add_breadcrumb t('breadcrumbs.diagnostics')
    add_breadcrumb @diagnostic.reference, algorithm_version_diagnostic_url(@final_diagnostic.diagnostic.version.algorithm, @final_diagnostic.diagnostic.version, @diagnostic, panel: 'final_diagnostics')
  end

  # DELETE /algorithms/:algorithm_id/versions/:version_id/diagnostics/:diagnostic_id/final_diagnostics/:id/remove_excluded_diagnostic
  # @return
  # Remove excluded diagnostic to final diagnostic
  def remove_exclusion
    @final_diagnosis_exclusion = NodeExclusion.final_diagnostic.find_by(final_diagnosis_exclusion_params)
    if @final_diagnosis_exclusion.destroy
      respond_to do |format|
        format.html { redirect_to algorithm_version_url(@algorithm.id, @version.id, panel: 'final_diagnoses_exclusions'), notice: t('flash_message.success_updated') }
        format.json { render json: @final_diagnosis_exclusion.excluding_node }
      end
    else
      respond_to do |format|
        format.html { redirect_to algorithm_version_url(@algorithm, @version, panel: 'final_diagnoses_exclusions'), alert: t('error') }
        format.json { render json: @final_diagnosis_exclusion.errors.full_messages, status: 422 }
      end
    end
  end

  private

  def set_breadcrumb
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm)
    add_breadcrumb t('breadcrumbs.versions')
    add_breadcrumb @version.name, algorithm_version_url(@algorithm, @version)
    add_breadcrumb t('breadcrumbs.diagnostics')
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
      :reference,
      :label_en,
      Language.label_params,
      :description_en,
      Language.description_params,
    )
  end

  def final_diagnosis_exclusion_params
    params.require(:node_exclusion).permit(
      :excluding_node_id,
      :excluded_node_id
    )
  end
end
