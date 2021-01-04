class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index
    add_breadcrumb t('breadcrumbs.settings')
    @languages = Language.all
    @studies = Study.all
  end

end
