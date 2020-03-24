class ManagementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_management, only: [:edit, :update, :update_translations, :destroy]
  before_action :set_algorithm, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_breadcrumb, only: [:new, :edit]

  def new
    add_breadcrumb t('breadcrumbs.new')

    @management = HealthCares::Management.new
  end

  def edit
    add_breadcrumb @management.label
    add_breadcrumb t('breadcrumbs.edit')
  end

  def create
    @management = @algorithm.health_cares.managements.new(management_params).becomes(HealthCares::Management)
    @management.type = HealthCares::Management

    if @management.save
      if params[:from] == 'rails'
        render json: { url: algorithm_url(@algorithm, panel: 'managements'), management: @management }
      else
        diagnostic = Diagnostic.find(params[:diagnostic_id])
        final_diagnostic = FinalDiagnostic.find(params[:final_diagnostic_id])
        final_diagnostic.health_cares << @management
        instance = diagnostic.components.create!(node: @management, final_diagnostic: final_diagnostic)

        render json: instance.generate_json
      end
    else
      render json: @management.errors.full_messages, status: 422
    end
  end

  def update
    if @management.update(management_params)
      if params[:from] == 'rails'
        render json: { url: algorithm_url(@algorithm, panel: 'managements'), management: @management }
      else
        render json: @management.as_json(methods: [:node_type, :type, :category_name])
      end
    else
      render json: @management.errors.full_messages, status: 422
    end
  end

  def destroy
    # If user remove 'disabled' css in button, we verify in controller
    if @management.dependencies?
      redirect_to algorithm_url(@algorithm, panel: 'managements'), alert: t('dependencies')
    else
      if @management.destroy
        redirect_to algorithm_url(@algorithm, panel: 'managements'), notice: t('flash_message.success_updated')
      else
        redirect_to algorithm_url(@algorithm, panel: 'managements'), alert: t('error')
      end
    end
  end

  # @params Management with the translations
  # Update the object with its translation without rendering a new page
  def update_translations
    if @management.update(management_params)
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
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm, panel: 'managements')
    add_breadcrumb t('breadcrumbs.managements')
  end

  def set_management
    @management = Node.find(params[:id])
  end

  def management_params
    params.require(:health_cares_management).permit(
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
