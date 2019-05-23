class ManagementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_management, only: [:edit, :update, :update_translations, :destroy]
  before_action :set_algorithm, only: [:new, :create, :edit, :update, :destroy]

  def new
    add_breadcrumb t('breadcrumbs.home'), root_url
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm, panel: 'managements')
    add_breadcrumb t('breadcrumbs.managements')
    add_breadcrumb t('breadcrumbs.new')

    @management = Management.new
  end

  def edit
    add_breadcrumb t('breadcrumbs.home'), root_url
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm, panel: 'managements')
    add_breadcrumb t('breadcrumbs.managements')
    add_breadcrumb @management.label
    add_breadcrumb t('breadcrumbs.edit')
  end

  def create
    @management = @algorithm.managements.new(management_params)

    if @management.save
      redirect_to algorithm_url(@algorithm, panel: 'managements'), notice: t('flash_message.success_created')
    else
      render :new
    end
  end

  def update
    if @management.update(management_params)
      redirect_to algorithm_url(@algorithm, panel: 'managements'), notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  def destroy
    # If user remove 'disabled' css in button, we verify in controller
    if @management.dependencies?
      redirect_to algorithm_url(@algorithm, panel: 'managements'), alert: t('dependencies')
    else
      if @management.destroy
        redirect_to algorithm_url(@algorithm, panel: 'managements'), notice: t('flash_message.success_updated')
      else
        redirect_to algorithm_url(@algorithm, panel: 'managements'), alert: t('error')
      end
    end
  end

  # @params Management with the translations
  # Update the object with its translation without
  def update_translations
    if @management.update(management_params)
      @json = { status: 'success', message: t('flash_message.success_updated')}
      render 'diagnostics/update_translations', formats: :js, status: :ok
    else
      @json = { status: 'alert', message: t('flash_message.update_fail')}
      render 'diagnostics/update_translations', formats: :js, status: :unprocessable_entity
    end
  end

  private

  def set_management
    @management = Management.find(params[:id])
  end

  def management_params
    params.require(:management).permit(
      :id,
      :reference,
      :label_en,
      Language.label_params,
      :description_en,
      Language.description_params,
      :algorithm_id,
    )
  end
end
