class Api::V1::AlgorithmVersionsController < Api::V1::ApplicationController

  def index
    # Get the devise make the request
    device = Device.find_by(mac_address: params[:mac_address])

    if device.present?
      if device.group.present?
        # Find the algorithm version available for this group
        algorithm_version = device.group.algorithm_versions.where('group_accesses.end_date IS NULL').first

        if algorithm_version.present?
          render json: AlgorithmVersionsService.generate_hash(1)
        else
          render json: { errors: t('.no_algorithm_version') }, status: :unprocessable_entity
        end
      else
        render json: { errors: t('.no_group') }, status: :unprocessable_entity
      end
    else
      render json: { errors: t('.device_not_exist') }, status: :unprocessable_entity
    end
  end
end
