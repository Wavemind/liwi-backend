class PredefinedSyndromesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_predefined_syndrome, only: [:edit, :update, :destroy, :update_translations, :diagram]
  before_action :set_algorithm, only: [:new, :create, :edit, :update, :destroy]
  layout 'diagram', only: [:diagram]

  def new
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm, panel: 'predefined_syndromes_scored')

    @predefined_syndrome_scored = PredefinedSyndrome.new
  end

  def edit
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm, panel: 'predefined_syndromes_scored')
    add_breadcrumb @predefined_syndrome_scored.label
  end

  def create
    @predefined_syndrome_scored = @algorithm.predefined_syndromes.new(predefined_syndrome_scored_params)

    if @predefined_syndrome_scored.save
      @predefined_syndrome_scored.components.create!(node: @predefined_syndrome_scored)
      redirect_to diagram_predefined_syndrome_url(@predefined_syndrome_scored), notice: t('flash_message.success_updated')
    else
      render :new
    end
  end

  def update
    if @predefined_syndrome_scored.update(predefined_syndrome_scored_params)
      redirect_to algorithm_url(@algorithm, panel: 'predefined_syndromes_scored'), notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  # React Diagram
  def diagram
    add_breadcrumb @predefined_syndrome_scored.algorithm.name, algorithm_url(@predefined_syndrome_scored.algorithm, panel: 'predefined_syndromes_scored')
  end

  private

  def set_predefined_syndrome
    @predefined_syndrome_scored = PredefinedSyndrome.find(params[:id])
  end

  def predefined_syndrome_scored_params
    params.require(:predefined_syndrome).permit(
      :id,
      :reference,
      :label_en,
      Language.label_params,
      :description_en,
      Language.description_params,
      :category_id,
      :algorithm_id,
      :min_score
      )
  end

end
