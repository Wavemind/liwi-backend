class PredefinedSyndromesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_predefined_syndrome, only: [:edit, :update, :destroy, :show]
  before_action :set_algorithm, only: [:new, :create, :edit, :update, :destroy]

  def show
    # Retrieve algorithm, since the show is not in the same route
    @algorithm = @predefined_syndrome.algorithm
    add_breadcrumb "#{@algorithm.name}", algorithm_url(@algorithm)
    add_breadcrumb "#{@predefined_syndrome.label}"

    @relation = Relation.new
    @relationable = @predefined_syndrome
  end

  def new
    add_breadcrumb "#{@algorithm.name}", algorithm_url(@algorithm)

    @predefined_syndrome = PredefinedSyndrome.new
  end

  def edit
    add_breadcrumb "#{@algorithm.name}", algorithm_url(@algorithm)
    add_breadcrumb "#{@predefined_syndrome.label}", predefined_syndrome_url(@predefined_syndrome)
  end

  def create
    @predefined_syndrome = @algorithm.predefined_syndromes.new(predefined_syndrome_params)

    if @predefined_syndrome.save
      redirect_to @predefined_syndrome, notice: t('flash_message.success_updated')
    else
      render :new
    end
  end

  def update
    if @predefined_syndrome.update(predefined_syndrome_params)
      redirect_to @algorithm, notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  def destroy
    if @predefined_syndrome.destroy
      redirect_to @algorithm, notice: t('flash_message.success_updated')
    else
      redirect_to @algorithm, alert: t('error')
    end
  end

  private

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
