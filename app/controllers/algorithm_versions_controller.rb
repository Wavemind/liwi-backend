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
      redirect_to algorithm_versions_url, notice: t('success_created')
    else
      render :new
    end
  end

  def update
    if @algorithm_version.update(algorithm_versions_params)
      redirect_to algorithm_versions_url, notice: t('success_updated')
    else
      render :edit
    end
  end

  private

  def set_algorithm
    @algorithm_version = AlgorithmVersion.find(params[:id])
  end

  def algorithm_versions_params
    params.require(:algorithm_version).permit(
      :id,
      :version,
      :json,
      :algorithm_id
    )
  end

end
