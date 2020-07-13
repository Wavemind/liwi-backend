class Api::V1::VersionsController < Api::V1::ApplicationController

  def index
    # Get the devise make the request
    device = Device.find_by(mac_address: params[:mac_address])

    if device.present?
      if device.group.present?
        if device.group.token == request.headers['group-token']
          # Find the algorithm version available for this group
          version = device.group.versions.where('group_accesses.end_date IS NULL').first

          if version.present?
            medal_r_json_version = params[:json_version]
            if medal_r_json_version == version.medal_r_json_version.to_s
              render json: {}, status: 204
            else
              render json: version.medal_r_json
            end
          else
            render json: { errors: t('.no_version') }, status: :unprocessable_entity
          end
        else
          render json:  { errors: t('.invalid_token') }, status: :unprocessable_entity
        end
      else
        render json: { errors: t('.no_group') }, status: :unprocessable_entity
      end
    else
      render json: { errors: t('.device_not_exist') }, status: :unprocessable_entity
    end
  end
end
