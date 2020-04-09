class Api::V1::GroupsController < Api::V1::ApplicationController

  def show
    device = Device.find(params[:id])

    if device.group.present?
      render json: {
        name: device.group.name,
        pin_code: device.group.pin_code,
        architecture: device.group.architecture,
        local_data_ip: device.group.local_data_ip,
        main_data_ip: device.group.main_data_ip,
        token: device.group.token,
      }
    else
      render json: { errors: t('.no_group') }, status: :unprocessable_entity
    end
  end
end
