class VersionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:index, :show, :new, :create, :edit, :update, :archive, :unarchive]
  before_action :set_version, only: [:show, :edit, :update, :archive, :unarchive]

  def index
    respond_to do |format|
      format.html
      format.json { render json: VersionDatatable.new(params, view_context: view_context) }
    end
  end

  def show
    add_breadcrumb "#{@algorithm.name}", algorithm_url(@algorithm)
    add_breadcrumb "#{@version.name}"

  end

  def new
    @version = Version.new
  end

  def create
    @version = @algorithm.versions.new(version_params)
    @version.user = current_user

    if @version.save
      redirect_to algorithm_url(@algorithm), notice: t('flash_message.success_created')
    else
      render :new
    end
  end

  def update
    if @version.update(version_params)
      redirect_to algorithm_url(@algorithm), notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  # PUT algorithms/:algorithm_id/algorithm_version/:id/archive
  # @params algorithm_version [AlgorithmVersion] version of algorithm to archive
  # @return redirect to algorithm_versions#index with flash message
  # Archive an algorithm version.
  def archive
    @version.archived = true

    if @version.save
      redirect_to algorithm_url(@algorithm), notice: t('flash_message.success_created')
    else
      redirect_to algorithm_url(@algorithm), danger: t('flash_message.update_fail')
    end
  end

  # PUT algorithms/:algorithm_id/algorithm_version/:id/unarchive
  # @params algorithm_version [AlgorithmVersion] algorithm version to archive
  # @return redirect to algorithms#index with flash message
  # Unarchive an algorithm version.
  def unarchive
    @version.archived = false

    if @version.save
      redirect_to algorithm_url(@algorithm), notice: t('flash_message.success_created')
    else
      redirect_to algorithm_url(@algorithm), danger: t('flash_message.update_fail')
    end
  end

  private

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
