class TreatmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_treatment, only: [:edit, :update]
  before_action :set_algorithm, only: [:new, :create, :edit, :update]

  def new
    @treatment = Treatment.new
  end

  def edit

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

  private

  def set_treatment
    @treatment = Treatment.find(params[:id])
  end

  def treatment_params
    params.require(:treatment).permit(
      :id,
      :reference,
      :label,
      :description,
      :algorithm_id,
    )
  end
end
