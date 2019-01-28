class DevicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_device, only: [:show]

  def index
    respond_to do |format|
      format.html
      format.json { render json: DeviceDatatable.new(params, view_context: view_context) }
    end
  end

  # GET devices/map
  # @params nil
  # @return [JSON] last connection of a devise with user's info
  # Used for the map on the dashboard for displaying where is the tablette
  def map
    render json: Device.all.to_json(methods: [:last_activity])
  end

  private

  def set_device
    @device = Device.find(params[:id])
  end

end
