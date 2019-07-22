class VersionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:index, :show, :new, :create, :edit, :update, :archive, :unarchive, :duplicate]
  before_action :set_breadcrumb, only: [:show, :new, :edit]
  before_action :set_version, only: [:show, :edit, :update, :archive, :unarchive, :duplicate]

  def index
    respond_to do |format|
      format.html
      format.json { render json: VersionDatatable.new(params, view_context: view_context) }
    end
  end

  def show
    add_breadcrumb @version.name
  end

  def new
    add_breadcrumb t('breadcrumbs.new')

    @version = Version.new
  end

  def edit
    add_breadcrumb @version.name, algorithm_version_url(@algorithm, @version)
    add_breadcrumb t('breadcrumbs.edit')
  end

  def create
    @version = @algorithm.versions.new(version_params)
    @version.user = current_user

    if @version.save
      redirect_to algorithm_url(@algorithm, panel: 'versions'), notice: t('flash_message.success_created')
    else
      set_breadcrumb
      add_breadcrumb t('breadcrumbs.new')
      render :new
    end
  end

  def update
    if @version.update(version_params)
      redirect_to algorithm_url(@algorithm, panel: 'versions'), notice: t('flash_message.success_updated')
    else
      set_breadcrumb
      add_breadcrumb t('breadcrumbs.edit')
      render :edit
    end
  end

  # PUT algorithms/:algorithm_id/version/:id/archive
  # @params version [Version] version of algorithm to archive
  # @return redirect to versions#index with flash message
  # Archive an algorithm version.
  def archive
    @version.archived = true

    if @version.save
      redirect_to algorithm_url(@algorithm, panel: 'versions'), notice: t('flash_message.success_created')
    else
      redirect_to algorithm_url(@algorithm, panel: 'versions'), danger: t('flash_message.update_fail')
    end
  end

  # @params [Version] version to duplicate
  # Duplicate a version with every diagnostics and their logics (Instances with their Conditions and Children), the FinalDiagnostics and Conditions attached to it
  def duplicate
    @version.diagnostics.each { |diagnostic| diagnostic.update(duplicating: true) }
    duplicated_version = @version.amoeba_dup

    if duplicated_version.save
      duplicated_version.diagnostics.each { |diagnostic| diagnostic.relink_instance }
      @version.diagnostics.each { |diagnostic| diagnostic.update(duplicating: false) }
      redirect_to algorithm_url(@algorithm), notice: t('flash_message.success_deleted')
    else
      render :new
    end
  end

  # PUT algorithms/:algorithm_id/version/:id/unarchive
  # @params version [Version] version to archive
  # @return redirect to algorithms#index with flash message
  # Unarchive an algorithm version.
  def unarchive
    @version.archived = false

    if @version.save
      redirect_to algorithm_url(@algorithm, panel: 'versions'), notice: t('flash_message.success_created')
    else
      redirect_to algorithm_url(@algorithm, panel: 'versions'), danger: t('flash_message.update_fail')
    end
  end

  private

  def set_breadcrumb
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm, panel: 'versions')
    add_breadcrumb t('breadcrumbs.versions')
  end

  def set_version
    @version = Version.find(params[:id])
  end

  def version_params
    params.require(:version).permit(
      :id,
      :name,
    )
  end
end
