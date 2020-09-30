class ManagementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_management, only: [:edit, :update, :destroy]
  before_action :set_algorithm, only: [:new, :create, :edit, :update, :destroy, :create_exclusion, :remove_exclusion]
  before_action :set_breadcrumb, only: [:new, :edit]

  def new
    add_breadcrumb t('breadcrumbs.new')

    @management = HealthCares::Management.new
    authorize @management
  end

  def edit
    add_breadcrumb @management.label
    add_breadcrumb t('breadcrumbs.edit')
  end

  def create
    @management = @algorithm.health_cares.managements.new(management_params).becomes(HealthCares::Management)
    authorize @management
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

  # POST algorithm/:algorithm_id/managements/create_exclusion
  # @params [Integer] excluding_node_id
  # @params [Integer] excluded_node_id
  # Create an exclusion between two managements
  def create_exclusion
    @management = HealthCares::Management.new
    authorize @management

    @management_exclusion = NodeExclusion.new(management_exclusion_params)
    @management_exclusion.node_type = :management
    if @management_exclusion.save
      redirect_to algorithm_url(@algorithm, panel: 'managements_exclusions'), notice: t('flash_message.success_updated')
    else
      redirect_to algorithm_url(@algorithm, panel: 'managements_exclusions'), alert: @management_exclusion.errors.full_messages
    end
  end

  # DELETE algorithm/:algorithm_id/managements/remove_exclusion
  # @params [Integer] excluding_node_id
  # @params [Integer] excluded_node_id
  # Remove an exclusion between two managements
  def remove_exclusion
    @management = HealthCares::Management.new
    authorize @management

    @management_exclusion = NodeExclusion.management.find_by(management_exclusion_params)
    if @management_exclusion.destroy
      redirect_to algorithm_url(@algorithm, panel: 'managements_exclusions'), notice: t('flash_message.success_updated')
    else
      redirect_to algorithm_url(@algorithm, panel: 'managements_exclusions'), alert: t('error')
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
    authorize @management
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

  def management_exclusion_params
    params.require(:node_exclusion).permit(
      :excluding_node_id,
      :excluded_node_id
    )
  end
end
