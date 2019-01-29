class Api::V1::ActivitiesController < ApplicationController

  def create
    device_params = activity_params[:device_attributes]

    # If devise doesn't exist, create it
    device = Device.find_or_create_by(mac_address: device_params[:mac_address]) do |device|
      device.mac_address = device_params[:mac_address]
      device.name = device_params[:name]
      device.model = device_params[:model]
      device.brand = device_params[:brand]
      device.os = device_params[:os]
      device.os_version = device_params[:os_version]
      device.status = 'active'
    end

    activity = Activity.new(activity_params)
    activity.device = device

    if device.save && activity.save
      render json: :success
    else
      render json: :unprocessable_entity
    end
  end

  private

  def activity_params
    params.require(:activity).permit(
      :longitude,
      :latitude,
      :timezone,
      :user_id,
      :version,
      device_attributes: [
        :id,
        :mac_address,
        :name,
        :model,
        :brand,
        :os,
        :os_version,
      ]
    )
  end

end
