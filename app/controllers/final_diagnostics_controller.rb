class FinalDiagnosticsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:show, :new, :create, :edit, :update, :destroy, :add_excluded_diagnostic, :remove_excluded_diagnostic]
  before_action :set_version, only: [:show, :new, :create, :edit, :update, :destroy, :add_excluded_diagnostic, :remove_excluded_diagnostic]
  before_action :set_diagnostic, only: [:show, :new, :create, :edit, :update, :destroy, :add_excluded_diagnostic, :remove_excluded_diagnostic]
  before_action :set_final_diagnostic, only: [:show, :edit, :update, :destroy, :add_excluded_diagnostic, :remove_excluded_diagnostic, :update_translations]

  def index
    respond_to do |format|
      format.html
      format.json { render json: FinalDiagnosticDatatable.new(params, view_context: view_context) }
    end
  end

  def show
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm)
    add_breadcrumb @version.name, algorithm_version_url(@algorithm, @version)
    add_breadcrumb @diagnostic.reference, algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic)
    add_breadcrumb @final_diagnostic.reference

    @final_diagnostic_health_care = FinalDiagnosticHealthCare.new
    @treatments = @final_diagnostic.final_diagnostic_health_cares.treatments
    @managements = @final_diagnostic.final_diagnostic_health_cares.managements
  end

  def new
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm)
    add_breadcrumb @version.name, algorithm_version_url(@algorithm, @version)
    add_breadcrumb @diagnostic.reference, algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic)

    @final_diagnostic = FinalDiagnostic.new
  end

  def edit
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm)
    add_breadcrumb @version.name, algorithm_version_url(@algorithm, @version)
    add_breadcrumb @diagnostic.reference, algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic)
    add_breadcrumb @final_diagnostic.reference, algorithm_version_diagnostic_final_diagnostic_url(@algorithm, @version, @diagnostic, @final_diagnostic)
  end

  def create
    @final_diagnostic = @diagnostic.final_diagnostics.new(final_diagnostic_params)

    if @final_diagnostic.save
      redirect_to algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic), notice: t('flash_message.success_created')
    else
      render :new
    end
  end

  def update
    if @final_diagnostic.update(final_diagnostic_params)
      redirect_to algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic), notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  def destroy
    if @final_diagnostic.destroy
      redirect_to algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic), notice: t('flash_message.success_deleted')
    else
      redirect_to algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic), alert: t('flash_message.update_fail')
    end
  end

  # POST /algorithms/:algorithm_id/versions/:version_id/diagnostics/:diagnostic_id/final_diagnostics/:id/add_excluded_diagnostic
  # @return
  # Add excluded diagnostic to final diagnostic
  def add_excluded_diagnostic
    if @final_diagnostic.update(final_diagnostic_params)
      redirect_to algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic), notice: t('flash_message.success_updated')
    else
      redirect_to algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic), alert: t('flash_message.update_fail')
    end
  end

  # DELETE /algorithms/:algorithm_id/versions/:version_id/diagnostics/:diagnostic_id/final_diagnostics/:id/remove_excluded_diagnostic
  # @return
  # Remove excluded diagnostic to final diagnostic
  def remove_excluded_diagnostic
    @final_diagnostic.excluded_diagnostic_id = nil
    if @final_diagnostic.save
      redirect_to algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic), notice: t('flash_message.success_updated')
    else
      redirect_to algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic), alert: t('flash_message.update_fail')
    end
  end

  # @params FinalDiagnostic with the translations
  # Update the object with its translation without
  def update_translations
    if @final_diagnostic.update(final_diagnostic_params)
      @json = { status: 'success', message: t('flash_message.success_updated')}
    else
      @json = { status: 'alert', message: t('flash_message.update_fail')}
    end

    render 'update_translations', formats: :js
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
      :reference_en,
      :reference_fr,
      :final_diagnostic_id,
      :description_en,
      :description_fr
    )
  end
end
