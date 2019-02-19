class ManagementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_management, only: [:edit, :update, :update_translations]
  before_action :set_algorithm, only: [:new, :create, :edit, :update]

  def new
    add_breadcrumb "#{@algorithm.name}", algorithm_url(@algorithm)

    @management = Management.new
  end

  def edit
    add_breadcrumb "#{@algorithm.name}", algorithm_url(@algorithm)
    add_breadcrumb "#{@management.reference}", algorithm_management_url(@algorithm, @management)
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

  def update_translations
    if @management.update(management_params)
      flash.now[:notice] = t('flash_message.success_updated')
    else
      flash.now[:alert] = t('flash_message.update_fail')
    end

    respond_to do |format|
      format.html
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
      :label_fr,
      :description_en,
      :description_fr,
      :algorithm_id,
    )
  end
end
