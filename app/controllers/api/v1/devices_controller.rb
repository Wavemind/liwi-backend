class Api::V1::DevicesController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :authenticate_user!, only: [:create]

  def create
    device = Device.find_by_mac_address(device_params[:mac_address])

    if device.blank?
      device = Device.create(device_params)
    end

    render json: device
  end

  def show
    # Mac address send instead of device id
    device = Device.find_by_mac_address(params[:id])
    if device.facility.present?
      render json: device.facility.as_json(include: [:medical_staffs])
    else
      render json: { errors: t('.no_health_facility') }, status: :unprocessable_entity
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
