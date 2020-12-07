# Home page
class DashboardController < ApplicationController
  before_action :authenticate_user!

  # @return [JSON] last connection of a device with user's info
  # Used for the map on the dashboard for displaying where is the device
  def index
    authorize policy_scope(Device)
    @devices = Device.all.to_json(methods: [:last_activity])
  end
end
