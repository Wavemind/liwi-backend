class DiagnosticsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:show, :new, :create, :edit, :update]
  before_action :set_version, only: [:show, :new, :create, :edit, :update]
  before_action :set_diagnostic, only: [:show, :edit, :update, :destroy, :update_translations]

  def index
    respond_to do |format|
      format.html
      format.json { render json: DiagnosticDatatable.new(params, view_context: view_context) }
    end
  end

  def show
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm)
    add_breadcrumb @version.name, algorithm_version_url(@algorithm, @version)
    add_breadcrumb @diagnostic.label

    @instance = Instance.new
    @instanceable = @diagnostic
    @conditions = @diagnostic.conditions
    @condition = Condition.new
  end

  def new
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm)
    add_breadcrumb @version.name, algorithm_version_url(@algorithm, @version)

    @diagnostic = Diagnostic.new
  end

  def edit
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm)
    add_breadcrumb @version.name, algorithm_version_url(@algorithm, @version)
    add_breadcrumb @diagnostic.reference, algorithm_version_diagnostic_url(@algorithm, @version)
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
    if @diagnostic.destroy
      redirect_to algorithm_version_diagnostic_url(@algorithm, @version, @diagnostic), notice: t('flash_message.success_deleted')
    else
      render :new
    end
  end

  # @params Diagnostic with the translations
  # Update the object with its translation without
  def update_translations
    if @diagnostic.update(diagnostic_params)
      @json = { status: 'success', message: t('flash_message.success_updated')}
      render 'update_translations', formats: :js, status: :ok
    else
      @json = { status: 'alert', message: t('flash_message.update_fail')}
      render 'update_translations', formats: :js, status: :unprocessable_entity
    end
  end

  private

  def set_diagnostic
    @diagnostic = Diagnostic.find(params[:id])
  end

  def diagnostic_params
    params.require(:diagnostic).permit(
      :id,
      :label_en,
      :label_fr,
      :reference
    )
  end
end
