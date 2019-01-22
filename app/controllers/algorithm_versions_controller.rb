class AlgorithmVersionsController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json { render json: AlgorithmVersionDatatable.new(params, view_context: view_context) }
    end
  end

  def show

  end

  def new
    @algorithm_version = AlgorithmVersion.new
  end

  def create
    @algorithm_version = AlgorithmVersion.new(algorithm_versions_params)

    if @algorithm_version.save
      redirect_to algorithm_versions_url, notice: t('flash_message.success_created')
    else
      render :new
    end
  end

  def update
    if @algorithm_version.update(algorithm_versions_params)
      redirect_to algorithm_versions_url, notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  # @params algorithm_version [AlgorithmVersion] version of algorithm to archive
  # @return redirect to algorithm_versions#index with flash message
  # Archive an algorithm version.
  def archive
    set_algorithm_version
    @algorithm_version.archived = true

    if @algorithm_version.save
      redirect_to algorithm_versions_url, notice: t('flash_message.success_created')
    else
      redirect_to algorithm_versions_url, danger: t('flash_message.update_fail')
    end
  end

  # @params algorithm [Algorithm] algorithm to archive
  # @return redirect to algorithms#index with flash message
  # Unarchive an algorithm version.
  def unarchive
    set_algorithm_version
    @algorithm_version.archived = false

    if @algorithm_version.save
      redirect_to algorithm_versions_url, notice: t('flash_message.success_created')
    else
      redirect_to algorithm_versions_url, danger: t('flash_message.update_fail')
    end
  end

  private

  def set_algorithm_version
    @algorithm_version = AlgorithmVersion.find(params[:id])
  end

  def algorithm_versions_params
    params.require(:algorithm_version).permit(
      :id,
      :version,
      :json,
      :algorithm_id,
      :user_id
    )
  end

end
