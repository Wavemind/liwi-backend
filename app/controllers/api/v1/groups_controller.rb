class Api::V1::GroupsController < Api::V1::ApplicationController

  def show
    device = Device.find(params[:id])
    if device.group.present?
      render json: device.group.as_json(include: [:medical_staffs])
    else
      render json: { errors: t('.no_group') }, status: :unprocessable_entity
    end
  end
end
