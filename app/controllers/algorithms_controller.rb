class AlgorithmsController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json { render json: AlgorithmDatatable.new(params, view_context: view_context) }
    end
  end

  def show

  end

  def new
    @algorithm = Algorithm.new
  end

  def create
    @algorithm = Algorithm.new(algorithm_params)

    if @algorithm.save
      redirect_to algorithms_url, notice: t('success_created')
    else
      render :new
    end
  end

  def update
    if @algorithm.update(algorithm_params)
      redirect_to algorithms_url, notice: t('success_updated')
    else
      render :edit
    end
  end

  private

  def set_algorithm
    @algorithm = Algorithm.find(params[:id])
  end

  def algorithm_params
    params.require(:algorithm).permit(
      :id,
      :name,
      :description
    )
  end

end
