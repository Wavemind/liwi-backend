class TreatmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_breadcrumb, only: [:new, :edit]
  before_action :set_treatment, only: [:edit, :update, :update_translations, :destroy]

  def new
    add_breadcrumb t('breadcrumbs.new')

    @treatment = Treatment.new
  end

  def edit
    add_breadcrumb @treatment.label
    add_breadcrumb t('breadcrumbs.edit')
  end

  def create
    @treatment = @algorithm.treatments.new(treatment_params)

    if @treatment.save
      redirect_to algorithm_url(@algorithm, panel: 'treatments'), notice: t('flash_message.success_created')
    else
      render :new
    end
  end

  def update
    if @treatment.update(treatment_params)
      redirect_to algorithm_url(@algorithm, panel: 'treatments'), notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  def destroy
    # If user remove 'disabled' css in button, we verify in controller
    if @treatment.dependencies?
      redirect_to algorithm_url(@algorithm, panel: 'treatments'), alert: t('dependencies')
    else
      if @treatment.destroy
        redirect_to algorithm_url(@algorithm, panel: 'treatments'), notice: t('flash_message.success_updated')
      else
        redirect_to algorithm_url(@algorithm, panel: 'treatments'), alert: t('error')
      end
    end
  end

  # @params Treatment with the translations
  # Update the object with its translation without
  def update_translations
    if @treatment.update(treatment_params)
      @json = { status: 'success', message: t('flash_message.success_updated')}
      render 'diagnostics/update_translations', formats: :js, status: :ok
    else
      @json = { status: 'alert', message: t('flash_message.update_fail')}
      render 'diagnostics/update_translations', formats: :js, status: :unprocessable_entity
    end
  end

  private

  def set_breadcrumb
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm, panel: 'treatments')
    add_breadcrumb t('breadcrumbs.treatments')
  end

  def set_treatment
    @treatment = Treatment.find(params[:id])
  end

  def treatment_params
    params.require(:treatment).permit(
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
