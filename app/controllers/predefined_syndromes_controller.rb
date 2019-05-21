class PredefinedSyndromesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_predefined_syndrome, only: [:edit, :update, :destroy, :update_translations, :diagram]
  before_action :set_algorithm, only: [:new, :create, :edit, :update, :destroy]
  layout 'diagram', only: [:diagram]

  def new
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm, panel: 'predefined_syndromes')

    @predefined_syndrome = PredefinedSyndrome.new
  end

  def edit
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm, panel: 'predefined_syndromes')
    add_breadcrumb @predefined_syndrome.label
  end

  def create
    @predefined_syndrome = @algorithm.predefined_syndromes.new(predefined_syndrome_params)

    if @predefined_syndrome.save
      @predefined_syndrome.components.create!(node: @predefined_syndrome)
      redirect_to diagram_predefined_syndrome_url(@predefined_syndrome), notice: t('flash_message.success_updated')
    else
      render :new
    end
  end

  def update
    if @predefined_syndrome.update(predefined_syndrome_params)
      redirect_to algorithm_url(@algorithm, panel: 'predefined_syndromes'), notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  def destroy
    # If user remove 'disabled' css in button, we verify in controller
    if @predefined_syndrome.dependencies?
      redirect_to algorithm_url(@algorithm, panel: 'predefined_syndromes'), alert: t('dependencies')
    else
      if @predefined_syndrome.destroy
        redirect_to algorithm_url(@algorithm, panel: 'predefined_syndromes'), notice: t('flash_message.success_updated')
      else
        redirect_to algorithm_url(@algorithm, panel: 'predefined_syndromes'), alert: t('error')
      end
    end
  end

  # @params PredefinedSyndrome with the translations
  # Update the object with its translation without
  def update_translations
    if @predefined_syndrome.update(predefined_syndrome_params)
      @json = { status: 'success', message: t('flash_message.success_updated')}
      render 'diagnostics/update_translations', formats: :js, status: :ok
    else
      @json = { status: 'alert', message: t('flash_message.update_fail')}
      render 'diagnostics/update_translations', formats: :js, status: :unprocessable_entity
    end
  end

  # React Diagram
  def diagram
    add_breadcrumb @predefined_syndrome.algorithm.name, algorithm_url(@predefined_syndrome.algorithm, panel: 'predefined_syndromes')
  end

  private

  def set_predefined_syndrome
    @predefined_syndrome = PredefinedSyndrome.find(params[:id])
  end

  def predefined_syndrome_params
    params.require(:predefined_syndrome).permit(
      :id,
      :reference,
      :label_en,
      Language.label_params,
      :description_en,
      Language.description_params,
      :category_id,
      :algorithm_id,
      )
  end

end
