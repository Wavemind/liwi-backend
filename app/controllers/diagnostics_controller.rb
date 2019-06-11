class DiagnosticsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:show, :new, :create, :edit, :update, :destroy, :duplicate]
  before_action :set_version, only: [:show, :new, :create, :edit, :update, :destroy, :duplicate]
  before_action :set_diagnostic, only: [:show, :edit, :update, :diagram, :health_cares_diagram, :update_translations, :validate]
  before_action :set_breadcrumb, only: [:show, :new, :edit]
  layout 'diagram', only: [:diagram]

  def index
    respond_to do |format|
      format.html
      format.json {render json: DiagnosticDatatable.new(params, view_context: view_context)}
    end
  end

  def show
    add_breadcrumb @diagnostic.label

    @instance = Instance.new
    @instanceable = @diagnostic
    @conditions = @diagnostic.conditions
    @condition = Condition.new
  end

  def new
    add_breadcrumb t('breadcrumbs.new')

    @diagnostic = Diagnostic.new
  end

  def edit
    add_breadcrumb @diagnostic.label, algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic)
    add_breadcrumb t('breadcrumbs.edit')
  end

  def create
    @diagnostic = @version.diagnostics.new(diagnostic_params)

    if @diagnostic.save
      redirect_to algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic), notice: t('flash_message.success_created')
    else
      render :new
    end
  end

  def update
    if @diagnostic.update(diagnostic_params)
      redirect_to algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic), notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  def destroy
    diagnostic = Diagnostic.includes(components: [:node, :conditions, children: [:node]]).find(params[:id])
    if diagnostic.controlled_destroy
      redirect_to algorithm_version_url(@algorithm, @version), notice: t('flash_message.success_deleted')
    else
      render :new
    end
  end

  # Generate react diagram
  def diagram
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @diagnostic.version.algorithm.name, algorithm_url(@diagnostic.version.algorithm)
    add_breadcrumb t('breadcrumbs.versions')
    add_breadcrumb @diagnostic.version.name, algorithm_version_url(@diagnostic.version.algorithm, @diagnostic.version)
    add_breadcrumb t('breadcrumbs.diagnostics')
  end

  # @params [Diagnostic] diagnostic to duplicate
  # Duplicate a diagnostic with the whole logic (Instances with their Conditions and Children), the FinalDiagnostics and Conditions attached to it
  def duplicate
    diagnostic = Diagnostic.includes(components: [:conditions, :children]).find(params[:id])
    duplicated_diagnostic = diagnostic.amoeba_dup

    if duplicated_diagnostic.save
      duplicated_diagnostic.relink_instance
      redirect_to algorithm_version_url(@algorithm, @version), notice: t('flash_message.success_deleted')
    else
      render :new
    end
  end

  # @params [Diagnostic] with the translations
  # Update the object with its translation without
  def update_translations
    if @diagnostic.update(diagnostic_params)
      @json = {status: 'success', messages: t('flash_message.success_updated')}
      render 'update_translations', formats: :js, status: :ok
    else
      @json = {status: 'alert', messages: t('flash_message.update_fail')}
      render 'update_translations', formats: :js, status: :unprocessable_entity
    end
  end

  # @params [Diagnostic]
  # Manually validate a diagnostic and return flash messages to display in the view
  def validate
    @diagnostic.manual_validate
    if @diagnostic.errors.messages.any?
      render json: {status: 'danger', messages: @diagnostic.errors.messages[:basic]}
    else
      render json: {status: 'success', messages: [t('flash_message.diagnostic.valid')]}
    end
  end

  private

  def set_breadcrumb
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm)
    add_breadcrumb t('breadcrumbs.versions')
    add_breadcrumb @version.name, algorithm_version_url(@algorithm, @version)
    add_breadcrumb t('breadcrumbs.diagnostics'), algorithm_version_url(@algorithm, @version)
  end

  def set_diagnostic
    @diagnostic = Diagnostic.find(params[:id])
  end

  def diagnostic_params
    params.require(:diagnostic).permit(
      :id,
      :reference,
      :label_en,
      Language.label_params
    )
  end
end
