class DiagnosticsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:show, :new, :create, :edit, :update, :destroy, :duplicate]
  before_action :set_version, only: [:show, :new, :create, :edit, :update, :destroy, :duplicate]
  before_action :set_diagnostic, only: [:show, :edit, :update, :diagram, :health_cares_diagram, :validate]
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

    @final_diagnostic = FinalDiagnostic.new
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
      set_breadcrumb
      add_breadcrumb t('breadcrumbs.new')
      render :new
    end
  end

  def update
    if @diagnostic.update(diagnostic_params)
      redirect_to algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic), notice: t('flash_message.success_updated')
    else
      set_breadcrumb
      add_breadcrumb t('breadcrumbs.edit')
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
    diagnostic.update(duplicating: true)
    duplicated_diagnostic = diagnostic.amoeba_dup

    if duplicated_diagnostic.save
      duplicated_diagnostic.relink_instance
      diagnostic.update(duplicating: false)
      redirect_to algorithm_version_url(@algorithm, @version), notice: t('flash_message.success_deleted')
    else
      redirect_to algorithm_version_url(@algorithm, @version), alert: t('flash_message.duplicate_fail')
    end
  end

  # @params [Diagnostic]
  # Manually validate a diagnostic and return flash messages to display in the view
  def validate
    @diagnostic.manual_validate
    if @diagnostic.errors.messages.any?
      render json: @diagnostic.errors.messages[:basic], status: 422
    elsif @diagnostic.warnings.messages.any?
      render json: @diagnostic.warnings.messages[:basic], status: 202
    else
      render json: [t('flash_message.diagnostic.valid')], status: 200
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
      :node_id,
      Language.label_params
    )
  end
end
