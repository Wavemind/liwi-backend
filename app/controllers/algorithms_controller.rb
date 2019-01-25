class AlgorithmsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:show, :edit, :update, :archive, :unarchive, :questions]

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
    @algorithm.user = current_user

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
  # Archive an algorithm. There is no impact for the user but if a parent is archived, the versions are considered archived too
  def archive
    @algorithm.archived = true

    if @algorithm.save
      redirect_to algorithms_url, notice: t('flash_message.success_created')
    else
      redirect_to algorithms_url, danger: t('flash_message.update_fail')
    end
  end

  # @params algorithm [Algorithm] algorithm to archive
  # @return redirect to algorithms#index with flash message
  # Unarchive an algorithm.
  def unarchive
    @algorithm.archived = false

    if @algorithm.save
      redirect_to algorithms_url, notice: t('flash_message.success_created')
    else
      redirect_to algorithms_url, danger: t('flash_message.update_fail')
    end
  end

  # @params algorithm [Algorithm] current algorithm
  # @return json of question
  # All questions available for current algorithm
  def questions
    respond_to do |format|
      format.html
      format.json { render json: QuestionDatatable.new(params, view_context: view_context) }
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
    )
  end

end
