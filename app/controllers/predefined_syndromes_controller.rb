class PredefinedSyndromesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_predefined_syndrome, only: [:edit, :update, :destroy, :show]
  before_action :set_algorithm, only: [:new, :create, :edit, :update, :destroy]


  def new
    @predefined_syndrome = PredefinedSyndrome.new
  end

  def create
    @predefined_syndrome = PredefinedSyndrome.new(predefined_syndrome_params)
    @predefined_syndrome.algorithms << @algorithm

    if @predefined_syndrome.save
      redirect_to @algorithm, notice: t('flash_message.success_updated')
    else
      redirect_to @algorithm, alert: t('error')
    end
  end

  def update
    if @predefined_syndrome.update(predefined_syndrome_params)
      redirect_to @algorithm, notice: t('flash_message.success_updated')
    else
      redirect_to @algorithm, alert: t('error')
    end
  end

  def show
    @relation = Relation.new
    @relationable = @predefined_syndrome
  end

  def destroy
    if @predefined_syndrome.destroy
      redirect_to @algorithm, notice: t('flash_message.success_updated')
    else
      redirect_to @algorithm, alert: t('error')
    end
  end

  private

  def set_algorithm
    @algorithm = Algorithm.find(params[:algorithm_id])
  end

  def set_predefined_syndrome
    @predefined_syndrome = PredefinedSyndrome.find(params[:id])
  end

  def predefined_syndrome_params
    params.require(:predefined_syndrome).permit(
      :id,
      :reference,
      :label,
      :description,
      :algorithm_id,
      )
  end

end
