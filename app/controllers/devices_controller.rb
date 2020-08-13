class DevicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_device, only: [:show]
  before_action :set_breadcrumb, only: [:show, :new]

  def index
    add_breadcrumb t('breadcrumbs.devices')

    respond_to do |format|
      format.html
      format.json { render json: DeviceDatatable.new(params, view_context: view_context) }
    end
  end

  def show
    add_breadcrumb @device.label
  end

  def new
    add_breadcrumb t('breadcrumbs.new')
    @device = Device.new
  end

  def create
    @device = Device.create(device_params)

    if @device.save
      redirect_to devices_url, notice: t('flash_message.success_created')
    else
      render :new
    end
  end

  # GET devices/map
  # @return [JSON] last connection of a devise with user's info
  # Used for the map on the dashboard for displaying where is the tablette
  def map
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
