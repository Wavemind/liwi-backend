class AlgorithmVersionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:show, :new, :create, :edit, :update, :archive, :unarchive]
  before_action :set_algorithm_version, only: [:show, :edit, :update, :archive, :unarchive]

  def index
    respond_to do |format|
      format.html
      format.json { render json: AlgorithmVersionDatatable.new(params, view_context: view_context) }
    end
  end

  def show

  end

  def new
    @algorithm = Algorithm.find(params[:algorithm_id])
    @algorithm_version = AlgorithmVersion.new
  end

  def create
    @algorithm_version = @algorithm.algorithm_versions.new(algorithm_versions_params)
    @algorithm_version.user = current_user

    if @algorithm_version.save
      redirect_to algorithm_url(@algorithm), notice: t('flash_message.success_created')
    else
      render :new
    end
  end

  def update
    if @algorithm_version.update(algorithm_versions_params)
      redirect_to algorithm_url(@algorithm), notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  # @params algorithm_version [AlgorithmVersion] version of algorithm to archive
  # @return redirect to algorithm_versions#index with flash message
  # Archive an algorithm version.
  def archive
    @algorithm_version.archived = true

    if @algorithm_version.save
      redirect_to algorithm_url(@algorithm), notice: t('flash_message.success_created')
    else
      redirect_to algorithm_url(@algorithm), danger: t('flash_message.update_fail')
    end
  end

  # @params algorithm_version [AlgorithmVersion] algorithm version to archive
  # @return redirect to algorithms#index with flash message
  # Unarchive an algorithm version.
  def unarchive
    @algorithm_version.archived = false

    if @algorithm_version.save
      redirect_to algorithm_url(@algorithm), notice: t('flash_message.success_created')
    else
      redirect_to algorithm_url(@algorithm), danger: t('flash_message.update_fail')
    end
  end

  private

  def set_algorithm
    @algorithm = Algorithm.find(params[:algorithm_id])
  end

  def set_algorithm_version
    @algorithm_version = AlgorithmVersion.find(params[:id])
  end

  def algorithm_versions_params
    params.require(:algorithm_version).permit(
      :id,
      :version,
      :json,
    )
  end
end
