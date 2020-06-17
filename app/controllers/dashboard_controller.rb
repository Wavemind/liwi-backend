# Home page
class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    begin
        raise
    rescue => e
      Appsignal.send_error(e, {algorithm: 'Hi there'})
    end
  end
end
