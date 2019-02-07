class Api::V1::AlgorithmVersionsController < Api::V1::ApplicationController

  def index
    device = Device.find_by(mac_address: device_params[:mac_address])
    algorithm_version = device.group.algorithm_versions.where('group_accesses.end_date IS NULL')

    if algorithm_version.present?
      render json: AlgorithmVersion.includes(:algorithm).to_json(include: { algorithm: { only: [:name, :description]}})
    else
      render json: {errors: t('.no_group')}, status: :unprocessable_entity
    end
  end

end
