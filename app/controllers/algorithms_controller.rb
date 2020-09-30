class AlgorithmsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:show, :edit, :update, :archive, :unarchive, :questions]

  def index
    authorize policy_scope(Algorithm)
    add_breadcrumb t('breadcrumbs.algorithms')

    respond_to do |format|
      format.html
      format.json { render json: AlgorithmDatatable.new(params, view_context: view_context) }
    end
  end

  def show
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @algorithm.name
  end

  def new
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb t('breadcrumbs.new')
    @algorithm = Algorithm.new
    authorize @algorithm
  end

  def edit
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm)
    add_breadcrumb t('breadcrumbs.edit')

  end

  def create
    @algorithm = Algorithm.new(algorithm_params)
    @algorithm.user = current_user
    authorize @algorithm
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

  # PUT algorithms/:id/archive
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

  # @params algorithm [Algorithm] current algorithm
  # @return json of managements
  # All managements available for current algorithm
  def managements
    authorize policy_scope(Algorithm)
    respond_to do |format|
      format.html
      format.json { render json: ManagementDatatable.new(params, view_context: view_context) }
    end
  end

  # @params algorithm [Algorithm] current algorithm
  # @return json of question
  # All questions available for current algorithm
  def questions
    authorize policy_scope(Algorithm)
    respond_to do |format|
      format.html
      format.json { render json: QuestionDatatable.new(params, view_context: view_context) }
    end
  end

  # @params algorithm [Algorithm] current algorithm
  # @return json of questions_sequences
  # All questions sequences available for current algorithm
  def questions_sequences
    authorize policy_scope(Algorithm)
    respond_to do |format|
      format.html
      format.json { render json: QuestionsSequenceDatatable.new(params, view_context: view_context) }
    end
  end

  # @params algorithm [Algorithm] current algorithm
  # @return json of questions_sequences_scored
  # All questions sequences scored available for current algorithm
  def questions_sequences_scored
    authorize policy_scope(Algorithm)
    respond_to do |format|
      format.html
      format.json { render json: QuestionsSequenceScoredDatatable.new(params, view_context: view_context) }
    end
  end

  # @params algorithm [Algorithm] current algorithm
  # @return json of drugs
  # All drugs available for current algorithm
  def drugs
    authorize policy_scope(Algorithm)
    respond_to do |format|
      format.html
      format.json { render json: DrugDatatable.new(params, view_context: view_context) }
    end
  end

  # @params algorithm [Algorithm] current algorithm
  # @return json of drugs
  # All drugs exclusions
  def drug_exclusions
    authorize policy_scope(Algorithm)
    respond_to do |format|
      format.html
      format.json { render json: DrugExclusionDatatable.new(params, view_context: view_context) }
    end
  end

  # @params algorithm [Algorithm] current algorithm
  # @return json of drugs
  # All managements exclusions
  def management_exclusions
    authorize policy_scope(Algorithm)
    respond_to do |format|
      format.html
      format.json { render json: ManagementExclusionDatatable.new(params, view_context: view_context) }
    end
  end

  # PUT algorithms/:id/unarchive
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

  private

  def set_algorithm
    @algorithm = Algorithm.find(params[:id])
    authorize @algorithm
  end

  def algorithm_params
    params.require(:algorithm).permit(
      :id,
      :name,
      :description,
      :age_limit,
      :age_limit_message
    )
  end
end
