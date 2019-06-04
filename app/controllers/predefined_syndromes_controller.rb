class PredefinedSyndromesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:new_scored, :edit_scored, :new, :create, :edit, :update, :destroy]
  before_action :set_predefined_syndrome, only: [:edit, :edit_scored, :update, :destroy, :update_translations, :diagram, :validate]
  before_action :set_score_category, only: [:new_scored, :edit_scored]
  before_action :set_breadcrumb, only: [:edit, :diagram]

  layout 'diagram', only: [:diagram]

  def new
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm, panel: 'predefined_syndromes')
    add_breadcrumb t('breadcrumbs.predefined_syndromes')
    add_breadcrumb t('breadcrumbs.new')

    @predefined_syndrome = PredefinedSyndrome.new
  end

  def edit
    add_breadcrumb @predefined_syndrome.label, diagram_predefined_syndrome_url(@predefined_syndrome)
    add_breadcrumb t('breadcrumbs.edit')
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

  # React Diagram
  def diagram
  end

  # @params PredefinedSyndrome with the translations
  # Update the object with its translation without
  def edit_scored
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm, panel: 'predefined_syndromes_scored')
    add_breadcrumb @predefined_syndrome.label
  end

  # @params PredefinedSyndrome with the translations
  # Update the object with its translation without
  def new_scored
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm, panel: 'predefined_syndromes_scored')

    @predefined_syndrome = PredefinedSyndrome.new
  end

  # @params PredefinedSyndrome with the translations
  # Update the object with its translation without
  def update_translations
    if @predefined_syndrome.update(predefined_syndrome_params)
      @json = { status: 'success', message: t('flash_message.success_updated') }
      render 'diagnostics/update_translations', formats: :js, status: :ok
    else
      @json = { status: 'alert', message: t('flash_message.update_fail') }
      render 'diagnostics/update_translations', formats: :js, status: :unprocessable_entity
    end
  end

  # @params [PredefinedSyndrome]
  # Manually validate a predefined syndrome and return flash messages to display in the view
  def validate
    @predefined_syndrome.manual_validate
    if @predefined_syndrome.errors.messages.any?
      respond_to do |format|
        format.html {redirect_to request.referer, alert: "<ul><li>#{@predefined_syndrome.errors.messages[:basic].join('</li><li>')}</li></ul>"}
      end
    else
      respond_to do |format|
        format.html {redirect_to request.referer, notice: t('flash_message.predefined_syndrome.valid')}
      end
    end
  end

  private

  def set_breadcrumb
    panel = (@predefined_syndrome.category.id === 8) ? 'predefined_syndromes_scored' : 'predefined_syndromes'
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @predefined_syndrome.algorithm.name, algorithm_url(@predefined_syndrome.algorithm, panel: panel)
    add_breadcrumb t('breadcrumbs.predefined_syndromes')
  end

  def set_predefined_syndrome
    @predefined_syndrome = PredefinedSyndrome.find(params[:id])
  end

  def set_score_category
    @category = Category.find(8)
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
      :min_score
      )
  end

end
