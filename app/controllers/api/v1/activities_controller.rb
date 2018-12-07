class Api::V1::ActivitiesController < ApplicationController

  def create
    device_params = activity_params[:device_attributes]

    device = Device.find_or_create_by(reference_number: device_params[:reference_number]) do |device|
      device.reference_number = device_params[:reference_number]
      device.name = device_params[:name]
      device.model = device_params[:model]
      device.brand = device_params[:brand]
      device.os = device_params[:os]
      device.os_version = device_params[:os_version]
      device.status = 'active'
    end

    activity = Activity.create(
      longitude: activity_params[:longitude],
      latitude: activity_params[:latitude],
      timezone: activity_params[:timezone],
      user_id: activity_params[:user_id],
      version: activity_params[:version],
      device_id: device.id
    )

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
        :reference_number,
        :name,
        :model,
        :brand,
        :os,
        :os_version,
      ]
    )
  end

end
