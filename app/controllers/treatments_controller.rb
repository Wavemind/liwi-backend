class TreatmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:new, :create, :edit, :update, :destroy, :create_from_diagram, :update_from_diagram]
  before_action :set_treatment, only: [:edit, :update, :update_translations, :destroy, :update_from_diagram]
  before_action :set_breadcrumb, only: [:new, :edit]

  def new
    add_breadcrumb t('breadcrumbs.new')

    @treatment = HealthCares::Treatment.new
  end

  def edit
    add_breadcrumb @treatment.label
    add_breadcrumb t('breadcrumbs.edit')
  end

  def create
    @treatment = @algorithm.health_cares.treatments.new(treatment_params)

    if @treatment.save
      redirect_to algorithm_url(@algorithm, panel: 'treatments'), notice: t('flash_message.success_created')
    else
      set_breadcrumb
      add_breadcrumb t('breadcrumbs.new')
      render :new
    end
  end

  def update
    if @treatment.update(treatment_params)
      redirect_to algorithm_url(@algorithm, panel: 'treatments'), notice: t('flash_message.success_updated')
    else
      set_breadcrumb
      add_breadcrumb t('breadcrumbs.edit')
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

  # POST
  # @return final_diagnostic node
  # Create a treatment node from diagram
  def create_from_diagram
    treatment = @algorithm.health_cares.treatments.new(treatment_params).becomes(HealthCares::Treatment)
    treatment.type = HealthCares::Treatment

    if treatment.save
      diagnostic = Diagnostic.find(params[:diagnostic_id])
      final_diagnostic = FinalDiagnostic.find(params[:final_diagnostic_id])
      final_diagnostic.health_cares << treatment
      diagnostic.components.create!(node: treatment, final_diagnostic: final_diagnostic)
      render json: {status: 'success', messages: [t('flash_message.success_created')], node: treatment.as_json(methods: :node_type)}
    else
      render json: {status: 'danger', errors: treatment.errors.messages, ok: false}
    end
  end

  # PUT
  # @return final_diagnostic node
  # Update a treatment node from diagram
  def update_from_diagram
    if @treatment.update(treatment_params)
      render json: {status: 'success', messages: [t('flash_message.success_created')], node: @treatment.as_json(methods: :node_type)}
    else
      render json: {status: 'danger', errors: @treatment.errors.messages, ok: false}
    end
  end

  # @params Treatment with the translations
  # Update the object with its translation without rendering a new page
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
    @treatment = Node.find(params[:id])
  end

  def treatment_params
    params.require(:health_cares_treatment).permit(
      :id,
      :reference,
      :type,
      :label_en,
      Language.label_params,
      :description_en,
      Language.description_params,
      :algorithm_id
    )
  end
end
