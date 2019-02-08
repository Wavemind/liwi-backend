class PredefinedSyndromesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:index, :destroy]
  before_action :set_algorithm_version, only: [:index, :destroy]
  before_action :set_predefined_syndrome, only: [:destroy]

  def index
    respond_to do |format|
      format.html
      format.json { render json: PredefinedSyndromeDatatable.new(params, view_context: view_context) }
    end
  end

  def destroy
    if @predefined_syndrome.destroy
      redirect_to algorithm_algorithm_version_url(@algorithm, @algorithm_version), notice: t('flash_message.success_updated')
    else
      raise
      redirect_to algorithm_algorithm_version_url(@algorithm, @algorithm_version), alert: t('error')
    end
  end

  private

  def set_predefined_syndrome
    @predefined_syndrome = PredefinedSyndrome.includes(relations: [:children, :conditions]).find(params[:id])
  end

  def set_algorithm
    @algorithm = Algorithm.find(params[:algorithm_id])
  end

  def set_algorithm_version
    @algorithm_version = AlgorithmVersion.find(params[:algorithm_version_id])
  end

end
