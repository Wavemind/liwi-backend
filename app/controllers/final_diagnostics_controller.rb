class FinalDiagnosticsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:new, :create, :edit, :update, :destroy, :add_excluded_diagnostic, :remove_excluded_diagnostic]
  before_action :set_version, only: [:new, :create, :edit, :update, :destroy, :add_excluded_diagnostic, :remove_excluded_diagnostic]
  before_action :set_diagnostic, only: [:new, :create, :edit, :update, :destroy, :add_excluded_diagnostic, :remove_excluded_diagnostic, :diagram]
  before_action :set_final_diagnostic, only: [:edit, :update, :destroy, :add_excluded_diagnostic, :remove_excluded_diagnostic, :update_translations, :diagram]
  layout 'diagram', only: [:diagram]

  def index
    respond_to do |format|
      format.html
      format.json {render json: FinalDiagnosticDatatable.new(params, view_context: view_context)}
    end
  end

  def new
    add_breadcrumb t('breadcrumbs.home'), root_url
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm)
    add_breadcrumb t('breadcrumbs.versions')
    add_breadcrumb @version.name, algorithm_version_url(@algorithm, @version)
    add_breadcrumb t('breadcrumbs.diagnostics')
    add_breadcrumb @diagnostic.label, algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic, panel: 'final_diagnostics')
    add_breadcrumb t('breadcrumbs.new')

    @final_diagnostic = FinalDiagnostic.new
  end

  def edit
    add_breadcrumb t('breadcrumbs.home'), root_url
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm)
    add_breadcrumb t('breadcrumbs.versions')
    add_breadcrumb @version.name, algorithm_version_url(@algorithm, @version)
    add_breadcrumb t('breadcrumbs.diagnostics')
    add_breadcrumb @diagnostic.label, algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic, panel: 'final_diagnostics')
    add_breadcrumb t('breadcrumbs.final_diagnostics')
    add_breadcrumb @final_diagnostic.label
    add_breadcrumb t('breadcrumbs.edit')
  end

  def create
    @final_diagnostic = @diagnostic.final_diagnostics.new(final_diagnostic_params)

    if @final_diagnostic.save
      @diagnostic.components.create!(node: @final_diagnostic)
      redirect_to algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic, panel: 'final_diagnostics'), notice: t('flash_message.success_created')
    else
      render :new
    end
  end

  def update
    if @final_diagnostic.update(final_diagnostic_params)
      redirect_to algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic, panel: 'final_diagnostics'), notice: t('flash_message.success_updated')
    else
      render :edit
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

  # POST /algorithms/:algorithm_id/versions/:version_id/diagnostics/:diagnostic_id/final_diagnostics/:id/add_excluded_diagnostic
  # @return
  # Add excluded diagnostic to final diagnostic
  def add_excluded_diagnostic
    if @final_diagnostic.update(final_diagnostic_params)
      render json: {status: 'success', message: t('flash_message.success_updated')}
    else
      render json: {status: 'alert', message: t('flash_message.update_fail')}
    end
  end

  # Generate react diagram
  def diagram
    add_breadcrumb t('breadcrumbs.home'), root_url
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb  @final_diagnostic.diagnostic.version.algorithm.name, algorithm_url(@final_diagnostic.diagnostic.version.algorithm)
    add_breadcrumb t('breadcrumbs.versions')
    add_breadcrumb @final_diagnostic.diagnostic.version.name, algorithm_version_url(@final_diagnostic.diagnostic.version.algorithm, @final_diagnostic.diagnostic.version)
    add_breadcrumb t('breadcrumbs.diagnostics')
    add_breadcrumb @diagnostic.reference, algorithm_version_diagnostic_url(@final_diagnostic.diagnostic.version.algorithm, @final_diagnostic.diagnostic.version, @diagnostic, panel: 'final_diagnostics')
  end

  # DELETE /algorithms/:algorithm_id/versions/:version_id/diagnostics/:diagnostic_id/final_diagnostics/:id/remove_excluded_diagnostic
  # @return
  # Remove excluded diagnostic to final diagnostic
  def remove_excluded_diagnostic
    @final_diagnostic.excluded_diagnostic = nil
    if @final_diagnostic.save
      render json: {status: 'success', message: t('flash_message.success_updated')}
    else
      render json: {status: 'alert', message: t('flash_message.update_fail')}
    end
  end

  # @params FinalDiagnostic with the translations
  # Update the object with its translation without
  def update_translations
    if @final_diagnostic.update(final_diagnostic_params)
      @json = {status: 'success', message: t('flash_message.success_updated')}
      render 'diagnostics/update_translations', formats: :js, status: :ok
    else
      @json = {status: 'alert', message: t('flash_message.update_fail')}
      render 'diagnostics/update_translations', formats: :js, status: :unprocessable_entity
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
      :reference,
      :label_en,
      Language.label_params,
      :final_diagnostic_id,
      :description_en,
      Language.description_params
    )
  end
end
