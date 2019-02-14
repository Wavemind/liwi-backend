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
  # @return [JSON] last connection of a devise with user's info
  # Used for the map on the dashboard for displaying where is the tablette
  def map
    render json: Device.all.to_json(methods: [:last_activity])
  end

  def new
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

  private

  def set_device
    @device = Device.find(params[:id])
  end

  def device_params
    params.require(:device).permit(
      :mac_address,
      :group_id
      )
  end
end
