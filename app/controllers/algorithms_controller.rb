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
      redirect_to algorithms_url, notice: t('flash_message.success_created')
    else
      render :new
    end
  end

  def update
    if @algorithm.update(algorithm_params)
      redirect_to algorithms_url, notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  # @params algorithm [Algorithm] algorithm to archive
  # @return redirect to algorithms#index with flash message
  # Archive an algorithm container. There is no impact for the user but if a parent is archived, the versions are considered archived too
  def archive
    set_algorithm
    @algorithm.archived = true

    if @algorithm.save
      redirect_to algorithms_url, notice: t('flash_message.success_created')
    else
      redirect_to algorithms_url, danger: t('flash_message.update_fail')
    end
  end

  # @params algorithm [Algorithm] algorithm to archive
  # @return redirect to algorithms#index with flash message
  # Unarchive an algorithm container.
  def unarchive
    set_algorithm
    @algorithm.archived = false

    if @algorithm.save
      redirect_to algorithms_url, notice: t('flash_message.success_created')
    else
      redirect_to algorithms_url, danger: t('flash_message.update_fail')
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
      :description,
      :user_id
    )
  end

end
