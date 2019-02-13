class ManagementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_management, only: [:edit, :update]
  before_action :set_algorithm, only: [:new, :create, :edit, :update]

  def new
    @management = Management.new
  end

  def edit

  end

  def create
    @management = Management.new(management_params)
    @management.algorithms << @algorithm

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

  private

  def set_management
    @management = Management.find(params[:id])
  end

  def management_params
    params.require(:management).permit(
      :id,
      :reference,
      :label,
      :description,
      :algorithm_id,
    )
  end
end
