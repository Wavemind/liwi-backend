class Api::V1::ActivitiesController < ApplicationController

  # TODO: Encore utile ?
  def create
    device_params = activity_params[:device_attributes]
    device = Device.find_by_mac_address(device_params[:mac_address])

    if device.present?
      device.attributes = device_params
    else
      device = Device.create(device_params)
    end

    activity = Activity.new(activity_params)
    activity.device = device

    if device.save && activity.save
      render json: :success
    else
      render json: {errors: t('.errors_on_save')}, status: :unprocessable_entity
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
