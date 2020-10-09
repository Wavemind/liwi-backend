class DevicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_device, only: [:show]
  before_action :set_breadcrumb, only: [:show]

  def index
    authorize policy_scope(Device)
    add_breadcrumb t('breadcrumbs.devices')

    respond_to do |format|
      format.html
      format.json { render json: DeviceDatatable.new(params, view_context: view_context) }
    end
  end

  def show
    authorize @device
    add_breadcrumb @device.label
  end

  # GET devices/map
  # @return [JSON] last connection of a devise with user's info
  # Used for the map on the dashboard for displaying where is the device
  def map
    authorize policy_scope(Device)
    render json: Device.all.to_json(methods: [:last_activity])
  end

  private

  def set_breadcrumb
    add_breadcrumb t('breadcrumbs.devices'), devices_url
  end

  def set_device
    @device = Device.find(params[:id])
  end

  def device_params
    params.require(:device).permit(
      :mac_address,
      :health_facility_id
      )
  end
end
