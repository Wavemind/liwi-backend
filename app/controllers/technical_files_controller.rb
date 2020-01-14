class TechnicalFilesController < ApplicationController
  before_action :authenticate_user!

  def index
    @apk = TechnicalFile.active
    @apks = TechnicalFile.last(10).reverse
  end

  def create
    @technical_file = TechnicalFile.new(technical_file_params)

    if @technical_file.save
      redirect_to technical_files_url, notice: t('flash_message.success_created')
    else
      redirect_to technical_files_url, alert: t('error')
    end
  end

  private

  def technical_file_params
    params.require(:technical_file).permit(
      :id,
      :file,
      :_destroy,
    )
  end
end
