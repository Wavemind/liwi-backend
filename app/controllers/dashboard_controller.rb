# Home page
class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize policy_scope(Device)
    @devices = Device.all.to_json(methods: [:last_activity])
  end
end
