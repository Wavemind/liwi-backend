class TreatmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_treatment, only: [:edit, :update, :update_translations]
  before_action :set_algorithm, only: [:new, :create, :edit, :update]

  def new
    add_breadcrumb "#{@algorithm.name}", algorithm_url(@algorithm)

    @treatment = Treatment.new
  end

  def edit
    add_breadcrumb "#{@algorithm.name}", algorithm_url(@algorithm)
    add_breadcrumb "#{@treatment.reference}", algorithm_treatment_url(@algorithm, @treatment)
  end

  def create
    @treatment = @algorithm.treatments.new(treatment_params)

    if @treatment.save
      redirect_to algorithm_url(@algorithm), notice: t('flash_message.success_created')
    else
      render :new
    end
  end

  def update
    if @treatment.update(treatment_params)
      redirect_to algorithm_url(@algorithm), notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  # @params Treatment with the translations
  # Update the object with its translation without
  def update_translations
    if @treatment.update(treatment_params)
      @json = { status: 'success', message: t('flash_message.success_updated')}
    else
      @json = { status: 'alert', message: t('flash_message.update_fail')}
    end

    render 'update_translations', formats: :js
  end

  private

  def set_treatment
    @treatment = Treatment.find(params[:id])
  end

  def treatment_params
    params.require(:treatment).permit(
      :id,
      :reference,
      :label_en,
      :label_fr,
      :description_en,
      :description_fr,
      :algorithm_id,
    )
  end
end
