class DrugsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:new, :create, :edit, :update, :destroy, :create_from_diagram, :update_from_diagram, :validate]
  before_action :set_drug, only: [:edit, :update, :update_translations, :destroy, :update_from_diagram]
  before_action :set_breadcrumb, only: [:new, :edit]

  def new
    add_breadcrumb t('breadcrumbs.new')

    @drug = HealthCares::Drug.new
  end

  def edit
    add_breadcrumb @drug.label
    add_breadcrumb t('breadcrumbs.edit')
  end

  def create
    @drug = @algorithm.health_cares.drugs.new(drug_params)

    if @drug.save
      redirect_to algorithm_url(@algorithm, panel: 'drugs'), notice: t('flash_message.success_created')
    else
      set_breadcrumb
      add_breadcrumb t('breadcrumbs.new')
      render :new
    end
  end

  def update
    if @drug.update(drug_params)
      redirect_to algorithm_url(@algorithm, panel: 'drugs'), notice: t('flash_message.success_updated')
    else
      set_breadcrumb
      add_breadcrumb t('breadcrumbs.edit')
      render :edit
    end
  end

  def destroy
    # If user remove 'disabled' css in button, we verify in controller
    if @drug.dependencies?
      redirect_to algorithm_url(@algorithm, panel: 'drugs'), alert: t('dependencies')
    else
      if @drug.destroy
        redirect_to algorithm_url(@algorithm, panel: 'drugs'), notice: t('flash_message.success_updated')
      else
        redirect_to algorithm_url(@algorithm, panel: 'drugs'), alert: t('error')
      end
    end
  end

  # POST
  # @return final_diagnostic node
  # Create a drug node from diagram
  def create_from_diagram
    drug = @algorithm.health_cares.drugs.new(drug_params).becomes(HealthCares::Drug)
    drug.type = HealthCares::Drug

    if drug.save
      diagnostic = Diagnostic.find(params[:diagnostic_id])
      final_diagnostic = FinalDiagnostic.find(params[:final_diagnostic_id])
      final_diagnostic.health_cares << drug
      diagnostic.components.create!(node: drug, final_diagnostic: final_diagnostic)
      render json: {status: 'success', messages: [t('flash_message.success_created')], node: drug.as_json(methods: [:node_type, :type])}
    else
      render json: {status: 'danger', errors: drug.errors.messages, ok: false}
    end
  end

  # PUT
  # @return final_diagnostic node
  # Update a drug node from diagram
  def update_from_diagram
    if @drug.update(drug_params)
      render json: {status: 'success', messages: [t('flash_message.success_created')], node: @drug.as_json(methods: [:node_type, :type])}
    else
      render json: {status: 'danger', errors: @drug.errors.messages, ok: false}
    end
  end

  # @params Drug with the translations
  # Update the object with its translation without rendering a new page
  def update_translations
    if @drug.update(drug_params)
      @json = { status: 'success', message: t('flash_message.success_updated')}
      render 'diagnostics/update_translations', formats: :js, status: :ok
    else
      @json = { status: 'alert', message: t('flash_message.update_fail')}
      render 'diagnostics/update_translations', formats: :js, status: :unprocessable_entity
    end
  end

  # POST algorithm/:algorithm_id/drugs/validate
  # @params Drug
  # @return errors messages if drug is not valid
  def validate
    drug = @algorithm.health_cares.drugs.new(drug_params).becomes(HealthCares::Drug)
    drug.type = HealthCares::Drug

    if drug.valid?
      render json: {status: 'success', messages: ['valid']}
    else
      render json: {status: 'danger', errors: drug.errors.messages, ok: false}
    end
  end

  private

  def set_breadcrumb
    add_breadcrumb t('breadcrumbs.algorithms'), algorithms_url
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm, panel: 'drugs')
    add_breadcrumb t('breadcrumbs.drugs')
  end

  def set_drug
    @drug = Node.find(params[:id])
  end

  def drug_params
    params.require(:health_cares_drug).permit(
      :id,
      :reference,
      :type,
      :label_en,
      Language.label_params,
      :description_en,
      Language.description_params,
      :algorithm_id,
      formulations_attributes: [
        :administration_route_id,
        :minimal_dose_per_kg,
        :maximal_dose_per_kg,
        :maximal_dose,
        :medication_form,
        :pill_size,
        :liquid_concentration,
        :doses_per_day,
        :unique_dose,
      ]
    )
  end
end
