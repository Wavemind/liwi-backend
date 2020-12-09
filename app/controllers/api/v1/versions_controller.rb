class Api::V1::VersionsController < Api::V1::ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :authenticate_user!, only: [:create]

  def show
    version = Version.find_by_id(params[:id])
    if version
      render json: version.medal_r_json
    else
      render json: { errors: t('api.v1.versions.show.invalid_version') }, status: :unprocessable_entity
    end
  end

  def retrieve_algorithm_version
    # Get the devise make the request
    device = Device.find_by(mac_address: params[:mac_address])

    if device.present?
      if device.health_facility.present?
        if device.health_facility.token == request.headers['health-facility-token']
          # Find the algorithm version available for this health facility
          version = device.health_facility.versions.where('health_facility_accesses.end_date IS NULL').first

          Activity.create(
              version: version,
              device: device,
              user: current_user,
              timezone: params[:timezone],
              latitude: params[:latitude],
              longitude: params[:longitude],
          )

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
        render json: { errors: t('.no_health_facility_html') }, status: :unprocessable_entity
      end
    else
      render json: { errors: t('.device_not_exist_html') }, status: :unprocessable_entity
    end
  end

  def json_test
    if params[:secret] == 'jest'
      version = Version.find(params[:version_id])
      render json: version.medal_r_json
    else
      render json: { errors: t('api.v1.versions.index.invalid_token') }, status: :unprocessable_entity
    end
  end

  # PUT /versions/json_from_facility
  # @params health_facility_id [Integer]
  # Get version from facility id and send back the json associated to it.
  def json_from_facility
    if params[:health_facility_id].present?
      facility = HealthFacility.find_by(id: params[:health_facility_id])
      if facility.present?
        facility_version = facility.health_facility_accesses.where(end_date: nil).first.version
        render json: facility_version.medal_r_json
      else
        render json: { errors: t('api.v1.versions.index.invalid_health_facility') }, status: :unprocessable_entity
      end
    else
      render json: { errors: t('api.v1.versions.index.no_health_facility_id') }, status: :unprocessable_entity
    end
  end

  # PUT /versions/facility_attributes
  # @params health_facility_id [Integer]
  # Get the facility from id and send back its attributes
  def facility_attributes
    if params[:health_facility_id].present?
      facility = HealthFacility.find_by(id: params[:health_facility_id])
      if facility.present?
        render json: facility.as_json(include: :medical_staffs)
      else
        render json: { errors: t('api.v1.versions.index.invalid_health_facility') }, status: :unprocessable_entity
      end
    else
      render json: { errors: t('api.v1.versions.index.no_health_facility_id') }, status: :unprocessable_entity
    end
  end
end
