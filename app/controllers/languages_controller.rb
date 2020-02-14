class LanguagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_language, only: [:show, :update, :destroy]

  def new
    @language = Language.new
  end

  def create
    @language = Language.new(language_params)

    if @language.save
      redirect_to settings_url, notice: t('flash_message.success_created')
    else
      render :new
    end
  end

  def update
    if @language.update(language_params)
      redirect_to settings_url, notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  def destroy
    if @language.destroy
      redirect_to settings_url, notice: t('flash_message.success_deleted')
    else
      redirect_to settings_url, alert: t('flash_message.delete_fail')
    end
  end

  private

  def set_language
    @language = Language.find(params[:id])
  end

  def language_params
    params.require(:language).permit(
      :id,
      :name,
      :code,
    )
  end
end
