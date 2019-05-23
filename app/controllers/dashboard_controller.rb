# Home page
class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    add_breadcrumb t('breadcrumbs.home')
  end
end
