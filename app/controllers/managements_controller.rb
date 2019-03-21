class ManagementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_management, only: [:edit, :update, :update_translations, :destroy]
  before_action :set_algorithm, only: [:new, :create, :edit, :update, :destroy]

  def new
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm)

    @management = Management.new
  end

  def edit
    add_breadcrumb @algorithm.name, algorithm_url(@algorithm)
    add_breadcrumb @management.reference, algorithm_management_url(@algorithm, @management)
  end

  def create
    @management = @algorithm.managements.new(management_params)

    if @management.save
      redirect_to algorithm_url(@algorithm), notice: t('flash_message.success_created')
    else
      render :new
    end
  end

  def update
    if @management.update(management_params)
      redirect_to algorithm_url(@algorithm), notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  def destroy
    # If user remove 'disabled' css in button, we verify in controller
    if @management.dependencies?
      redirect_to algorithm_url(@algorithm), alert: t('dependencies')
    else
      if @management.destroy
        redirect_to algorithm_url(@algorithm), notice: t('flash_message.success_updated')
      else
        redirect_to algorithm_url(@algorithm), alert: t('error')
      end
    end
  end

  # @params Management with the translations
  # Update the object with its translation without
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

  def set_management
    @management = Management.find(params[:id])
  end

  def management_params
    params.require(:management).permit(
      :id,
      :reference,
      :label_en,
      Language.label_params,
      :description_en,
      Language.description_params,
      :algorithm_id,
    )
  end
end
