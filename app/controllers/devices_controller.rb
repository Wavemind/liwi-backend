class DevicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_device, only: [:show]

  def index
    respond_to do |format|
      format.html
      format.json { render json: DeviceDatatable.new(params, view_context: view_context) }
    end
  end

  def map
    render json: Device.all.to_json(methods: [:last_activity])
  end

  private

  def set_device
    @device = Device.find(params[:id])
  end

end
