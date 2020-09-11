class DrugsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:new, :create, :edit, :update, :destroy, :validate]
  before_action :set_drug, only: [:edit, :update, :update_translations, :destroy]
  before_action :set_breadcrumb, only: [:new, :edit]

  def new
    add_breadcrumb t('breadcrumbs.new')

    @drug = HealthCares::Drug.new
    authorize @drug
  end

  def edit
    add_breadcrumb @drug.label
    add_breadcrumb t('breadcrumbs.edit')
  end

  def create
    authorize policy_scope(HealthCares::Drug)
    drug = HealthCares::Drug.new(drug_params)
    drug.algorithm = @algorithm
    drug.formulations.map { |f| f.node = drug }

    if drug.save
      if params[:from] === 'rails'
        render json: { url: algorithm_url(@algorithm, panel: 'drugs') }
      else
        render json: drug.as_json(include: [:formulations], methods: [:node_type, :type, :category_name])
      end
    else
      render json: drug.errors.full_messages, status: 422
    end
  end

  def update
    if @drug.update(drug_params)
      if params[:from] == 'rails'
        render json: { url: algorithm_url(@algorithm, panel: 'drugs') }
      else
        render json: @drug.as_json(include: [:formulations], methods: [:node_type, :type, :category_name])
      end
    else
      render json: @drug.errors.full_messages, status: 422
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

  # GET
  # @return Hash
  # Return attributes of drug and formulation that are listed
  def lists
    authorize policy_scope(HealthCares::Drug)
    render json: HealthCares::Drug.list_attributes
  end

  # @params Drug with the translations
  # Update the object with its translation without rendering a new page
  def update_translations
    if @drug.update(drug_params)
      @json = { status: 'success', message: t('flash_message.success_updated') }
      render 'diagnostics/update_translations', formats: :js, status: :ok
    else
      @json = { status: 'alert', message: t('flash_message.update_fail') }
      render 'diagnostics/update_translations', formats: :js, status: :unprocessable_entity
    end
  end

  # POST algorithm/:algorithm_id/drugs/validate
  # @params Drug
  # @return errors messages if drug is not valid
  def validate
    authorize policy_scope(HealthCares::Drug)
    drug = HealthCares::Drug.new(drug_params).becomes(HealthCares::Drug)
    drug.algorithm = @algorithm

    if drug.valid?
      render json: { status: 'success', messages: ['valid'] }
    else
      render json: { status: 'danger', errors: drug.errors.messages, ok: false }
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
    authorize @drug
  end

  def drug_params
    params.require(:health_cares_drug).permit(
      :id,
      :reference,
      :type,
      :is_antibiotic,
      :is_anti_malarial,
      :label_en,
      Language.label_params,
      :description_en,
      Language.description_params,
      :algorithm_id,
      formulations_attributes: [
        :id,
        :administration_route_id,
        :minimal_dose_per_kg,
        :maximal_dose_per_kg,
        :maximal_dose,
        :medication_form,
        :dose_form,
        :liquid_concentration,
        :doses_per_day,
        :unique_dose,
        :by_age,
        :breakable,
        :description_en,
        :injection_instructions_en,
        :_destroy
      ]
    )
  end
end
