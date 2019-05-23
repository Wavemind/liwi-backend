class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index
    add_breadcrumb t('breadcrumbs.home'), root_url
    add_breadcrumb t('breadcrumbs.settings')
  end

end
