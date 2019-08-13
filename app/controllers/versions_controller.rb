class VersionsController < ApplicationController
  before_action :authenticate_user!, except: [:change_triage_order]
  before_action :set_algorithm, only: [:index, :show, :new, :create, :edit, :update, :archive, :unarchive, :create_triage_condition, :remove_triage_condition]
  before_action :set_breadcrumb, only: [:show, :new, :edit]
  before_action :set_version, only: [:show, :edit, :update, :archive, :unarchive, :change_triage_order, :create_triage_condition, :remove_triage_condition]

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

  # PUT algorithms/:algorithm_id/version/:id/change_triage_order
  # @params version [Version] version of algorithm we change order of
  # Change the order of the triage questions for this version
  def change_triage_order
    if @version.update(triage_questions_order: params[:triage_questions_order])
      render json: {result: 'success'}
    else
      render json: {result: 'error'}
    end
  end

  # Create a condition between a triage question and a chief complaint
  def create_triage_condition
    instance = Instance.find(version_params[:triage_id])
    cc_condition = Instance.find(version_params[:cc_id]).node.answers.first

    condition = Condition.new(referenceable: instance, first_conditionable: cc_condition)

    if condition.save
      redirect_to algorithm_version_url(@algorithm, @version, panel: 'triage_conditions'), notice: t('flash_message.success_created')
    else
      redirect_to algorithm_version_url(@algorithm, @version, panel: 'triage_conditions'), notice: t('flash_message.create_fail')
    end
  end

  # Remove a condition between a triage question and a chief complaint
  def remove_triage_condition
    condition = Condition.find(params[:condition_id])

    if condition.destroy
      redirect_to algorithm_version_url(@algorithm, @version, panel: 'triage_conditions'), notice: t('flash_message.success_created')
    else
      redirect_to algorithm_version_url(@algorithm, @version, panel: 'triage_conditions'), notice: t('flash_message.create_fail')
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
      :triage_questions_order,
      :triage_id,
      :cc_id
    )
  end
end
