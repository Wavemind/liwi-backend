class Api::V1::DevicesController < ApplicationController

  def create
    device = Device.new(device_params)
    if device.save
      render json: device
    else
      render json: { errors: t('.errors_on_save') }, status: :unprocessable_entity
    end
  end

  def show
    # Mac address send instead of device id
    device = Device.find_by_mac_address(params[:id])
    if device.group.present?
      render json: device.group.as_json(include: [:medical_staffs])
    else
      render json: { errors: t('.no_group') }, status: :unprocessable_entity
    end
  end

  private

  def device_params
    params.require(:device).permit(
      :id,
      :mac_address,
      :name,
      :model,
      :brand,
      :os,
      :os_version,
    )
  end
end
