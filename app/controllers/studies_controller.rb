class StudiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_study, only: [:show, :update, :edit, :destroy]

  def new
    authorize policy_scope(Study)
    @study = Study.new
  end

  def create
    @study = Study.new(study_params)
    authorize @study
    if @study.save
      redirect_to settings_url, notice: t('flash_message.success_created')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @study.update(study_params)
      redirect_to settings_url, notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  def destroy
    if @study.destroy
      redirect_to settings_url, notice: t('flash_message.success_deleted')
    else
      redirect_to settings_url, alert: t('flash_message.delete_fail')
    end
  end

  private

  def set_study
    @study = Study.find(params[:id])
    authorize @study
  end

  def study_params
    params.require(:study).permit(
      :id,
      :label,
      :description_en,
      )
  end
end
